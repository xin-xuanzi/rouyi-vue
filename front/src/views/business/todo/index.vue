<template>
  <div class="app-container">

    <el-tabs v-model="activeName" class="demo-tabs">
      <el-tab-pane label="基本信息" name="first">
        <todo-base-info :task-id="taskId" />
      </el-tab-pane>
      <el-tab-pane label="流程图" name="second">
        asfd
      </el-tab-pane>
    </el-tabs>



  </div>

</template>

<script setup name="Todo">

import {useRoute} from "vue-router";

import TodoBaseInfo from "@/views/business/todo/todoBaseInfo.vue";
import {ref} from "vue";
const route = useRoute();
const activeName = ref("first")
const taskId = route.params.taskId;

</script>

<style scoped>

:deep(.demo-tabs > .el-tabs__content) {
  padding: 32px;
  color: #6b778c;
  font-size: 32px;
  font-weight: 600;
}
</style>