<template>
  <div class="app-container" v-loading="loading"  v-cloak>
    <el-empty :image-size="100" description="未找到对应的数据" v-if="empty"/>
    <el-tabs v-model="activeName" class="demo-tabs" v-else>
      <el-tab-pane label="基本信息" name="first">
        <todo-base-info :task-id="taskId" @show-empty="isEmpty"/>
      </el-tab-pane>
      <el-tab-pane label="流程图" name="second">
        流程图
      </el-tab-pane>
    </el-tabs>



  </div>

</template>

<script setup name="Todo">

import {useRoute} from "vue-router";

import TodoBaseInfo from "@/views/business/todo/todoBusinessInfo.vue";
import {ref} from "vue";
const route = useRoute();
const activeName = ref("first")
const empty = ref(false);
const loading = ref(false);
const taskId = route.params.taskId;

function isEmpty(val) {
  empty.value = val
  loading.value = false;
}
</script>

<style scoped>
[v-cloak] {
  display: none;
}
:deep(.demo-tabs > .el-tabs__content) {
  padding: 32px;
  color: #6b778c;
  font-size: 32px;
  font-weight: 600;
}
</style>