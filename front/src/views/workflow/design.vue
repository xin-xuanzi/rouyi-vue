<template>
  <div class="app-container">
    <el-container>
      <el-header style="background: white">
        <layout-header v-model="activeSelect" @publish="publishProcess" @save="save"></layout-header>
      </el-header>
      <div class="layout-body">
        <form-base-setting ref="baseSetting" v-show="activeSelect === 'baseSetting'"/>
        <process-design ref="processDesign" v-show="activeSelect === 'processDesign'" :fullscreen="fullscreen"/>
      </div>
      <w-dialog :showFooter="false" v-model="validVisible" title="设置项检查">
        <el-steps align-center :active="validStep" finish-status="success">
          <el-step v-for="(step, i) in validOptions" :title="step.title" :key="i"
                   :icon="step.icon" :status="step.status" :description="step.description"/>
        </el-steps>
        <el-result :icon="validIcon" :title="errTitle" :subTitle="validResult.desc">
          <template #icon>
            <i style="font-size: 30px" v-if="!validResult.finished" class="el-icon-loading"></i>
          </template>

          <template #sub-title>
            <div class="err-info" v-if="validResult.errs.length > 0">
              <ellipsis hover-tip v-for="(err, i) in validResult.errs" :key="i + '_err'" :content="err">
                <i slot="pre" class="el-icon-warning-outline"></i>
              </ellipsis>
            </div>
          </template>

          <template #extra>
            <el-button type="primary" v-if="validResult.finished" size="default" @click="doAfter">
              {{ validResult.action }}
            </el-button>
          </template>
        </el-result>
      </w-dialog>
    </el-container>
  </div>

</template>

<script>
import {defaultProcess, deploy, detail, save as saveWorkflow} from "@/api/flowProcess/flowProcess";
import LayoutHeader from './LayoutHeader'
import WDialog from "@/components/Common/WDialog";
import FormBaseSetting from '@/views/workflow/layout/FormBaseSetting'
import ProcessDesign from '@/views/workflow/layout/ProcessDesign'
import FormProSetting from '@/views/workflow/layout/FormProSetting'
import flowProcess from "@/store/modules/flowProcess";
import Ellipsis from "@/components/Common/Ellipsis";

export default {
  name: "Design",
  components: {
    LayoutHeader, FormBaseSetting,
    ProcessDesign,
    WDialog,
    FormProSetting,
    Ellipsis,
  },
  props:{
    fullscreen:{
      type: Boolean,
      default:false
    },
    actExpandProcessId:{
      type:String
    }
  },
  data() {
    return {
      isNew: true,
      validStep: 0,
      timer: null,
      activeSelect: 'baseSetting',
      validVisible: false,
      validResult: {},
      validOptions: [
        {title: '基础信息', description: '', icon: '', status: ''},
        {title: '审批流程', description: '', icon: '', status: ''},
        // {title: '扩展设置', description: '', icon: '', status: ''}
      ],
      validComponents: ['baseSetting', 'processDesign'
        // , 'proSetting'
      ],
    }
  },
  computed: {
    setup() {
      return flowProcess().design
    },
    errTitle() {
      if (this.validResult.finished && !this.validResult.success) {
        return this.validResult.title + ` (${this.validResult.errs.length}项错误) 😥`
      }
      return this.validResult.title
    },
    validIcon() {
      if (!this.validResult.finished) {
        return 'el-icon-loading'
      } else if (this.validResult.success) {
        return 'success'
      } else {
        return 'warning'
      }
    }
  },
  created() {
    this.showValiding()

    //判断传参，决定是新建还是加载原始数据
    this.loadInitFrom()
    if (this.$isNotEmpty(this.actExpandProcessId)) {
      this.isNew = false
      this.loadFormInfo(this.actExpandProcessId)
    }

  },
  beforeDestroy() {
    this.stopTimer()
  },
  methods: {
    loadFormInfo(id) {
      detail(id).then(rsp => {
        console.log(rsp.data)
        let form = rsp.data;
        let baseInfo = {
          expandProcessId: form.expandProcessId,
          businessCode: form.businessCode,
          name: form.name,
          settings: {
            notify: {
              types: ["APP"],
              title: "消息通知标题"
            }
          },
          process:JSON.parse(form.source),
          remark: form.remark
        }

        flowProcess().loadProcess(baseInfo);
      }).catch(err => {
        this.$message.error(err)
      })
    },
    loadInitFrom() {
      let baseInfo = {
        expandProcessId: null,
        businessCode: "",
        name: "未命名流程",
        settings: {
          notify: {
            types: ["APP"],
            title: "消息通知标题"
          }
        },
        process:defaultProcess(),
        remark: "备注说明"
      }
      flowProcess().loadProcess(baseInfo);
    },
    validateDesign() {
      this.validVisible = true
      this.validStep = 0
      this.showValiding()
      this.stopTimer()
      this.timer = setInterval(() => {
        this.validResult.errs = this.$refs[this.validComponents[this.validStep]].validate()
        if (Array.isArray(this.validResult.errs) && this.validResult.errs.length === 0) {
          this.validStep++;
          if (this.validStep >= this.validOptions.length) {
            this.stopTimer()
            this.showValidFinish(true)
          }
        } else {
          this.stopTimer()
          this.validOptions[this.validStep].status = 'error'
          this.showValidFinish(false, this.getDefaultValidErr())
        }
      }, 300)
    },
    getDefaultValidErr() {
      switch (this.validStep) {
        case 0:
          return '请检查基础设置项';
        case 1:
          return '请检查审批流程，查看对应标注节点错误信息'
        default:
          return '未知错误'
      }
    },
    showValidFinish(success, err) {
      this.validResult.success = success
      this.validResult.finished = true
      this.validResult.title = success ? '校验完成 😀' : '校验失败 '
      this.validResult.desc = success ? '设置项校验成功，是否部署？' : err
      this.validResult.action = success ? '部 署' : '去修改'
    },
    showValiding() {
      this.validResult = {
        errs: [],
        finished: false,
        success: false,
        title: '检查中...',
        action: '处理',
        desc: '正在检查设置项'
      }
      this.validStep = 0
      this.validOptions.forEach(op => {
        op.status = ''
        op.icon = ''
        op.description = ''
      })
    },
    doAfter() {
      if (this.validResult.success) {
        this.doPublish()
      } else {
        this.activeSelect = this.validComponents[this.validStep]
        this.validVisible = false
      }
    },
    stopTimer() {
      if (this.timer) {
        clearInterval(this.timer)
      }
    },
    save() {
      debugger
      //this.validateDesign()
      // 直接保存 不做验证
      let template = {
        expandProcessId: this.setup.expandProcessId,
        businessCode: this.setup.businessCode,
        name: this.setup.name,
        notifyTypes: this.setup.settings.notify.types.join(","),
        notifyTitle: this.setup.settings.notify.title,
        source: JSON.stringify(this.setup.process),
        remark: this.setup.remark
      }

      saveWorkflow(template).then(rsp => {
        this.validVisible = false;
        this.$message.success("保存流程成功");
      }).catch(err => {
        this.$message.error(err)
      })
    },
    publishProcess() {
      this.validateDesign()
    },
    doPublish() {
      this.$confirm('确认发布后流程立即生效，是否继续?', '提示', {
        confirmButtonText: '发布',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        console.log(this.setup)
        let template = {
          expandProcessId: this.setup.expandProcessId,
          businessCode: this.setup.businessCode,
          name: this.setup.name,
          notifyTypes: this.setup.settings.notify.types.join(","),
          notifyTitle: this.setup.settings.notify.title,
          source: JSON.stringify(this.setup.process),
          remark: this.setup.remark
        }
        if (this.isNew || !this.$isNotEmpty(this.setup.formId)) {
          deploy(template).then(rsp => {
            this.validVisible = false;
            this.$message.success("创建流程成功");
            this.$emit("deploy-success");
          }).catch(err => {
            this.$message.error(err)
          })
        } else {
          // updateFormDetail(template).then(rsp => {
          //   this.$message.success("更新表单成功")
          //   this.$router.push("/formsPanel")
          // }).catch(err => {
          //   this.$message.error(err)
          // })
        }
      })
    }
  }
}
</script>

<style lang="scss" scoped>
.el-header {
  --el-header-padding: 0px 0px;
}

.layout-body {
  width: 100%;
}

:deep(.el-step) {
  .is-success {
    color: #2a99ff;
    border-color: #2a99ff;
  }
}

.err-info {
  max-height: 180px;
  overflow-y: auto;

  & > div {
    padding: 5px;
    margin: 2px 0;
    width: 220px;
    text-align: left;
    border-radius: 3px;
    background: rgb(242 242 242);
  }

  i {
    margin: 0 5px;
  }
}

::-webkit-scrollbar {
  width: 2px;
  height: 2px;
  background-color: white;
}

::-webkit-scrollbar-thumb {
  border-radius: 16px;
  background-color: #e8e8e8;
}

.app-container {
  padding-top: 0px;
}
</style>
