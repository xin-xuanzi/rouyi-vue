<template>
  <div class="base-setup">
    <el-form ref="baseSetting" :model="setup" label-position="top" label-width="80px">
      <el-form-item label="流程名称" :rules="getRule('请输入流程名称')" prop="name">
        <el-input v-model="setup.name" size="default"></el-input>
      </el-form-item>
      <el-form-item label="所属业务" :rules="getRule('请选择业务分组')" class="group" prop="businessCode">
        <el-select v-model="setup.businessCode" placeholder="请选择分组" size="default" :disabled="true">
          <el-option v-for="op in fromGroup" :key="op.code"
                     :label="op.businessName" :value="op.businessCode">
          </el-option>

        </el-select>
      </el-form-item>
      <el-form-item label="流程说明">
        <el-input placeholder="请输入流程说明" v-model="setup.remark" type="textarea" show-word-limit
                  :autosize="{ minRows: 2, maxRows: 5}" maxlength="500"></el-input>
      </el-form-item>
      <el-form-item label="消息通知方式" :rules="getRule('请选择消息通知方式')">
        <el-select v-model="setup.settings.notify.types" value-key="name"
                   placeholder="选择消息通知方式" style="width: 30%;"
                   size="default" clearable multiple collapse-tags>
          <el-option v-for="(wc, index) in notifyTypes" :label="wc.name" :key="index" :value="wc.type"></el-option>
        </el-select>
        <el-input size="default" v-model="setup.settings.notify.title" style="width: 70%; float:right;" placeholder="消息通知标题"></el-input>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
import {businessEnableList} from "@/api/flowProcess/business";
import flowProcess from "@/store/modules/flowProcess";

export default {
  name: "FormBaseSetting",
  components: {},
  data() {
    return {
      nowUserSelect: null,
      showIconSelect: false,
      select: [],
      newGroup: '',
      fromGroup: [],
      notifyTypes:[
        {type:'APP',name:'应用内通知'},
        {type:'EMAIL',name:'邮件通知'},
        {type:'SMS',name:'短信通知'},
        {type:'WX',name:'微信通知'},
        {type:'DING',name:'钉钉通知'},
      ],
      rules:{
        formName:[{}],
        groupId: [],
      }
    }
  },
  computed: {
    setup() {
      return flowProcess().design;
    }

  },
  created() {
  },
  mounted(){
    this.getBusinessList()
  },
  methods: {
    getRule(msg){
      return [{ required: true, message: msg, trigger: 'blur' }]
    },
    getBusinessList(){
      businessEnableList(0).then(rsp => {
        this.fromGroup = rsp.data
      }).catch(err => this.$message.error('获取业务分类异常'))
    },
    validate(){
      this.$refs.baseSetting.validate()
      let err = []
      if (!this.$isNotEmpty(this.setup.name)){
        err.push('流程名称未设置')
      }
      if (!this.$isNotEmpty(this.setup.businessCode)){
        err.push('流程分组未设置')
      }
      if (this.setup.settings.notify.types.length === 0){
        err.push('审批消息通知方式未设置')
      }
      return err
    }
  }
}
</script>

<style lang="scss" scoped>
:deep(.el-select-dropdown) {
  display: none;
}

.icon-select {
  display: flex;
  flex-wrap: wrap;
  i {
    cursor: pointer;
    font-size: large;
    padding: 10px;
    max-width: 38px !important;
    &:hover {
      box-shadow: 0 0 10px 2px #C2C2C2;
    }
  }
}

:deep(.select-u) {
  width: 100%;
}

.base-setup {
  overflow: auto;
  width: 40%;
  min-width: 500px;
  height: calc(100vh - 310px);
  background: #ffffff;
  margin: 10px auto 0;
  padding: 15px 20px;

  i:first-child {
    position: relative;
    cursor: pointer;
    font-size: xx-large;
    color: #ffffff;
    border-radius: 10px;
    padding: 10px;
  }

  .change-icon {
    margin-left: 20px;

    span {
      font-size: small;
      color: #7a7a7a;
      margin-right: 15px;
    }

    i {
      cursor: pointer;
      color: #7a7a7a;
      font-size: x-large;
    }
  }

  :deep(.el-form-item__label) {
    padding: 0;
    font-weight: bold;
  }

  :deep(.el-form-item) {
    margin-bottom: 10px;
  }
}

:deep(.group) {
  .el-select {
    width: calc(100% - 0px);
  }

  .el-button {
    margin-left: 10px;
    width: 120px;
  }
}

::-webkit-scrollbar {
  width: 4px;
  height: 4px;
  background-color: #f8f8f8;
}

::-webkit-scrollbar-thumb {
  border-radius: 16px;
  background-color: #e8e8e8;
}
</style>
