<template>
  <div class="box" v-if="record.length > 0">
    <div class="header">
      审批记录
    </div>

    <el-timeline>
      <el-timeline-item  :timestamp="node.time" placement="top" v-for="node in record">
        <el-card>
          <div>
            <span class="fs-1 ml10" >{{node.actName}}
              <template v-if="!node.itemDtoList">
                :{{node.userName}}
              </template>
            </span>
          </div>
          <template  v-if="node.itemDtoList && node.itemDtoList.length > 0">
            <el-divider />
            <el-table
                size="small"
                :data="node.itemDtoList"
                style="width: 100%"
            >
              <el-table-column prop="date" label="审批人"  >
                <template #default="scope">
                  {{scope.row.userName}}
                </template>
              </el-table-column>
              <el-table-column  label="状态"  >
                <template #default="scope">
                  <el-tag type="danger" v-if="scope.row.approvalResult === 'REJECT'">驳 回</el-tag>
                  <el-tag v-else-if="scope.row.approvalResult === 'PASS'">同 意</el-tag>
                  <el-tag type="info" v-else>待审批</el-tag>
                </template>
              </el-table-column>
              <el-table-column prop="comment" label="审批意见"  >
                <template #default="scope">

                  {{scope.row.comment}}
                </template>
              </el-table-column>
              <el-table-column prop="time" label="审批时间" />
            </el-table>
          </template>

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

const tableData = [
  {
    date: '2016-05-03',
    name: 'Tom',
    address: 'No. 189, Grove St, Los Angeles',
  },
  {
    date: '2016-05-02',
    name: 'Tom',
    address: 'No. 189, Grove St, Los Angeles',
  },
  {
    date: '2016-05-04',
    name: 'Tom',
    address: 'No. 189, Grove St, Los Angeles',
  },
  {
    date: '2016-05-01',
    name: 'Tom',
    address: 'No. 189, Grove St, Los Angeles',
  },
]
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