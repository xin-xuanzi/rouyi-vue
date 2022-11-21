<template>
  <div>
    <div class="header">
      <el-menu :default-active="modelValue" active-text-color="#409eff" class="el-menu-demo" mode="horizontal"
               @select="handleSelect">
        <el-menu-item index="baseSetting" @click="to('baseSetting')">① 基础信息</el-menu-item>
        <el-menu-item index="processDesign" @click="to('processDesign')">② 审批流程 </el-menu-item>
      </el-menu>
      <div class="publish">
        <el-button size="small" @click="save" icon="Document">保存</el-button>
        <el-button size="small" type="primary" @click="publish" icon="Promotion">发布</el-button>
      </div>
    </div>
  </div>
</template>

<script>
import flowProcess from "@/store/modules/flowProcess";
export default {
  name: "LayoutHeader",
  props:{
    modelValue: {
      type: String,
      default: 'baseSetup'
    }
  },
  data() {
    return {
      viewCode: false,
    };
  },
  computed: {
    setup() {
      return flowProcess().design
    }
  },
  created() {
    this.check()
  },
  mounted() {
    if (document.body.offsetWidth <= 970) {
      this.$msgbox.alert("本设计器未适配中小屏幕，建议您在PC电脑端浏览器进行操作")
    }

    this.listener()
  },
  methods: {
    publish() {
      this.$emit('publish')
    },
    save() {
      this.$emit('save')
    },
    valid() {
      if (!this.$isNotEmpty(this.setup.group)) {
        this.$message.warning('请选择分组')
        this.$router.push('/layout/baseSetup')
        return false;
      }
      return true;
    },
    exit() {
      this.$confirm('未发布的内容将不会被保存，是否直接退出 ?', '提示', {
        confirmButtonText: '退出',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        //window.location.reload()
        //this.$store.commit('clearTemplate')
        this.$router.push('/formsPanel')
      })
    },
    to(path) {
      this.$emit('update:modelValue', path)
    },
    handleSelect(key, keyPath) {
      console.log(key, keyPath);
    },
    listener() {
      window.onunload = this.closeBefore()
      window.onbeforeunload = this.closeBefore()
    },
    closeBefore() {
      //alert("您将要离开本页")
      return false
    },
    check() {
      if (flowProcess().isEdit === null) {
        //this.$router.push("/workPanel");
      }
    }
  }
}
</script>
<style lang="scss" scoped>

:deep(.header) {
  width: 100%;
  position: relative;

  .el-menu {
    top: 0;
    z-index: 999;
    display: flex;
    justify-content: center;
    width: 100%;
  }

  .publish {
    position: absolute;
    top: 15px;
    right: 20px;
    z-index: 1000;

    i {
      margin-right: 6px;
    }

    button {
      border-radius: 15px;
    }
  }

  .back {
    position: absolute;
    z-index: 1000;
    top: 10px;
    left: 20px;
    font-size: small;

    span {
      i {
        border-radius: 10px;
        padding: 7.8px;
        font-size: 20px;
        color: #ffffff;
        margin: 0 10px;
      }
    }

  }
}
</style>
