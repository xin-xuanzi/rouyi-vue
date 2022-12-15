<template>
  <div>
    <component :is="currentTabComponent" :id="businessId"></component>

    <div class="btn-group">
      <el-button type="danger">驳回</el-button>
      <el-button type="success">同意</el-button>
    </div>
    <approval-record v-if="processInstanceId" :process-instance-id="processInstanceId"></approval-record>
  </div>
</template>

<script setup name="todoBaseInfo.vue">
import {queryTodoDetail} from "@/api/flowProcess/flowProcess";

import businessComponents from "@/utils/businessComponent";
import {defineAsyncComponent} from "vue";
import ApprovalRecord from "@/views/business/todo/approvalRecord.vue";

const props = defineProps({
  taskId:String
})
const viewPath = ref("");
const businessId = ref("");
const currentTabComponent = shallowRef(null);
const processInstanceId = ref(null);

async function getTodo() {
  let res = await queryTodoDetail(props.taskId)

  if (res.data == null) {

  } else {
    businessId.value = res.data.caseInstanceId
    processInstanceId.value = res.data.processInstanceId
    viewPath.value = res.data.viewPath
    let val = businessComponents[res.data.businessCode];
    currentTabComponent.value = defineAsyncComponent(val);
  }
}

getTodo()
</script>

<style scoped>
.btn-group {
  text-align: center;
}
</style>