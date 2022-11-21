<template>

  <el-popover placement="bottom-start"
              :hide-after="100"
              ref="insertBtnPopover"
              title="添加流程节点" trigger="click" width="310px">
    <template #default>
      <div class="node-select">
        <div @click="addApprovalNode">
          <el-icon size="33px" style="color:rgb(255, 148, 62);"><Avatar /></el-icon>
          <span>审批人</span>
        </div>
        <div @click="addCcNode">
          <el-icon size="33px"  style="color:rgb(50, 150, 250);"><Promotion /></el-icon>
          <span>抄送人</span>
        </div>
        <div @click="addConditionsNode">
          <el-icon size="33px"  style="color:rgb(21, 188, 131);"><Share /></el-icon>
          <span>条件分支</span>
        </div>
        <div @click="addConcurrentsNode">
          <el-icon style="color:#718dff;"><Operation /></el-icon>
          <span>并行分支</span>
        </div>
<!--        <div @click="addDelayNode">-->
<!--          <el-icon size="33px"  style="color:#f25643;"><Timer /></el-icon>-->
<!--          <span>延迟等待</span>-->
<!--        </div>-->
<!--        <div @click="addTriggerNode">-->
<!--          <el-icon size="33px"  style="color:#15BC83;"><SetUp /></el-icon>-->
<!--          <span>触发器</span>-->
<!--        </div>-->
      </div>
    </template>


    <template #reference>
      <el-button  type="primary" circle>
        <el-icon><Plus /></el-icon>
      </el-button>
    </template>

  </el-popover>
</template>

<script>

import flowProcess from "@/store/modules/flowProcess";
import {ElPopover, ElButton} from "element-plus";
export default {
  name: "InsertButton",
  components: {
    ElPopover,
    ElButton,
  },
  data() {
    return {

    }
  },
  computed:{
  },
  methods: {
    addApprovalNode(){
      this.$emit('insertNode', "APPROVAL")
      this.$refs['insertBtnPopover'].hide()
    },
    addCcNode(){
      this.$emit('insertNode', "CC")
      this.$refs['insertBtnPopover'].hide()
    },
    addDelayNode(){
      this.$emit('insertNode', "DELAY")
      this.$refs['insertBtnPopover'].hide()
    },
    addConditionsNode(){
      this.$emit('insertNode', "CONDITIONS")
      this.$refs['insertBtnPopover'].hide()
    },
    addConcurrentsNode(){
      this.$emit('insertNode', "CONCURRENTS")
      this.$refs['insertBtnPopover'].hide()
    },
    addTriggerNode(){
      this.$emit('insertNode', "TRIGGER")
      this.$refs['insertBtnPopover'].hide()
    }
  }
}
</script>

<style lang="scss" scoped>
.node-select{
  div{
    display: inline-block;
    margin: 5px 5px;
    cursor: pointer;
    padding: 10px 15px;
    border: 1px solid #F8F9F9;
    background-color: #F8F9F9;
    border-radius: 10px;
    width: 130px;
    position: relative;
    span{
      position: absolute;
      left: 65px;
      top: 18px;
    }
    &:hover{
      background-color: #fff;
      box-shadow: 0 0 8px 2px #d6d6d6;
    }
    i{
      font-size: 25px;
      padding: 5px;
      border: 1px solid #dedfdf;
      border-radius: 14px;
    }
  }
}
</style>
