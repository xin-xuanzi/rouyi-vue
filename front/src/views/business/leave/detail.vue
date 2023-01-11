<template>
  <div class="app-container" v-if="formData">
    <el-descriptions
        class="margin-top"
        title="请假详情"
        :column="2"
        border
    >

      <el-descriptions-item>
        <template #label>
          <div class="cell-item">
            <el-icon>
              <user/>
            </el-icon>
            申请人
          </div>
        </template>
        {{ formData.userName }}
      </el-descriptions-item>
      <el-descriptions-item>
        <template #label>
          <div class="cell-item">
            <el-icon>
              <Notification/>
            </el-icon>
            所属部门
          </div>
        </template>
        {{ formData.deptName }}
      </el-descriptions-item>
      <el-descriptions-item>
        <template #label>
          <div class="cell-item">
            <el-icon>
              <Calendar/>
            </el-icon>
            开始日期
          </div>
        </template>
        {{ formData.startDate }}
        <el-tag>{{ formData.startTime }}</el-tag>
      </el-descriptions-item>
      <el-descriptions-item>
        <template #label>
          <div class="cell-item">
            <el-icon>
              <tickets/>
            </el-icon>
            结束日期
          </div>
        </template>
        {{ formData.endDate }}
        <el-tag>{{ formData.endTime }}</el-tag>
      </el-descriptions-item>
      <el-descriptions-item>
        <template #label>
          <div class="cell-item">
            <el-icon>
              <ScaleToOriginal/>
            </el-icon>
            请假类型
          </div>
        </template>
        产假
      </el-descriptions-item>
      <el-descriptions-item>
        <template #label>
          <div class="cell-item">
            <el-icon>
              <ScaleToOriginal/>
            </el-icon>
            请假天数
          </div>
        </template>
        {{ formData.duration }}
      </el-descriptions-item>
      <el-descriptions-item>
        <template #label>
          <div class="cell-item">
            <el-icon>
              <ScaleToOriginal/>
            </el-icon>
            请假原因
          </div>
        </template>
        {{ formData.remark }}
      </el-descriptions-item>
    </el-descriptions>
  </div>
</template>

<script setup name="LeaveDetail">
import {leaveDetail} from "@/api/business/leave";
import {nextTick, onMounted, ref} from "vue";

const props = defineProps({
  id: String
})
const formData = ref(null);

async function queryLeaveDerail() {
  let res = await leaveDetail(props.id)
  nextTick(() => {
    formData.value = res.data
  })

}


onMounted(() => {
  queryLeaveDerail()
})


</script>

<style scoped>

</style>