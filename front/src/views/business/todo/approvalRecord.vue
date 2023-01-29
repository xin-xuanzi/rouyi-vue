<template>
  <div class="box" v-if="record.length > 0">
    <div class="header">
      审批记录
    </div>

    <el-timeline>
      <el-timeline-item  :timestamp="item.time" placement="top" v-for="item in record">
        <el-card>
          <div>
            <el-tag type="danger" v-if="item.approvalResult === 'REJECT'">驳 回</el-tag>
            <el-tag v-else>同 意</el-tag>
            <span class="fs-1 ml10" >{{item.taskName}}</span>
            <span class="fs-2"> {{item.userName || '张珊'}}</span>

          </div>
          <el-divider />

          <p>{{item.comment}}</p>
        </el-card>
      </el-timeline-item>

    </el-timeline>
  </div>
</template>

<script setup name="ApprovalRecord">
import {queryApprovalRecord} from "@/api/flowProcess/flowProcess";
 const props = defineProps({
    processInstanceId:String
  })
const record = ref([]);
function loadRecord() {
  queryApprovalRecord(props.processInstanceId).then(res => {
    record.value = res.data
  })
}
loadRecord()
</script>

<style scoped>
.box{
  width: 60%;
}
.fs-2{
  font-size: 1rem;
  color: #333333;
  font-weight: 550;
  margin-left: 10px;
}
:deep(.el-card__body){
  padding: 10px 14px 8px 14px !important;
}
:deep(.el-divider--horizontal){
  margin: 10px 0;
}
.header{
  color: var(--el-text-color-primary);
  font-size: 17px;
  padding-left: 20px;
  padding-bottom: 15px;
  padding-top: 25px;
}
</style>