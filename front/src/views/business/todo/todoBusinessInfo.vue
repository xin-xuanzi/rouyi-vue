<template>

  <div >
    <component  :is="currentTabComponent" :id="businessId"></component>

    <div class="btn-group" v-if="loginUserId === assignee && endTime == null">
      <el-button type="danger" @click="showRejectDialog">驳回</el-button>
      <el-button type="success" @click="pass">同意</el-button>
    </div>

    <approval-record v-if="showRecord" :process-instance-id="processInstanceId"></approval-record>

    <el-dialog  v-model="rejectDialog" title="驳回意见">
      <div class="el-item">

        <div class="el-item__content">
          <el-input
              v-model="comment"
              :autosize="{ minRows: 4, maxRows: 6 }"
              type="textarea"
              placeholder="驳回意见"
          />
        </div>
      </div>

      <template #footer>
      <span class="dialog-footer">
        <el-button @click="rejectDialog = false">
          取消
        </el-button>
        <el-button type="primary" @click="reject">
          确定
        </el-button>
      </span>
      </template>
    </el-dialog>
  </div>
</template>

<script setup name="todoBaseInfo.vue">
import {approve, queryTodoDetail} from "@/api/flowProcess/flowProcess";

import businessComponents from "@/utils/businessComponent";
import {defineAsyncComponent, nextTick} from "vue";
import ApprovalRecord from "@/views/business/todo/approvalRecord.vue";
import useUserStore from '@/store/modules/user'
const { proxy } = getCurrentInstance();

const viewPath = ref("");
const businessId = ref("");
const loginUserId = ref("");
const assignee = ref("");
const comment = ref("");
const endTime = ref(null);
const loading = ref(true);
const rejectDialog = ref(false);
const showRecord = ref(false);
const currentTabComponent = shallowRef(null);
const processInstanceId = ref(null);
const businessCode = ref(null);

const props = defineProps({
  taskId:String
})

const emits = defineEmits(['showEmpty']);

async function getTodo() {
  let res = await queryTodoDetail(props.taskId)

  if (res.data == null) {
    emits('showEmpty', true)
  } else {
    businessId.value = res.data.caseInstanceId
    assignee.value = res.data.assignee
    endTime.value = res.data.endTime
    businessCode.value = res.data.businessCode

    await nextTick(() =>{
      loginUserId.value = useUserStore().userId;
      loading.value = false;
      processInstanceId.value = res.data.processInstanceId
      showRecord.value = true;
      
      emits('showEmpty', false)
    })

    viewPath.value = res.data.viewPath
    let val = businessComponents[res.data.businessCode];
    currentTabComponent.value = defineAsyncComponent(val);

  }
}

function buildApproveData() {
    return {
      processInstance: processInstanceId.value,
      business: businessCode.value,
    }
}
function showRejectDialog() {
  rejectDialog.value = true;
}
/**
 * 驳回
 */
function reject() {
  const commentStr = comment.value;
  if (commentStr === '') {
    proxy.$modal.msgError(`请填写驳回意见 !`);
    return;
  }

  proxy.$modal.loading("正在提交");

  let result = buildApproveData();
  result.result = 'REJECT';
  result.comment = comment.value;
  approve(result).then(res => {
    proxy.$modal.closeLoading();
    proxy.$modal.msgSuccess("审批成功");
    comment.value = '';
    endTime.value = new Date();
    showRecord.value = false;
    nextTick(() =>{
      showRecord.value = true;
    })
    rejectDialog.value = false;

  })
}



/**
 * 同意
 */
function pass() {
  proxy.$modal.loading("正在提交");

  let result = buildApproveData();
  result.result = 'PASS';
  result.comment = "同意";
  approve(result).then(res => {
    proxy.$modal.closeLoading();
    proxy.$modal.msgSuccess("审批成功");
    comment.value = '';
    endTime.value = new Date();
    showRecord.value = false;
    nextTick(() =>{
      showRecord.value = true;
    })
    rejectDialog.value = false;

  })
}

getTodo()

</script>

<style scoped>
.btn-group {
  text-align: center;
}
</style>