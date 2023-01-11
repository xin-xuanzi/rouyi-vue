<template>
  <div class="app-container home">
    <el-row :gutter="20">
      <el-col :xs="24" :sm="24" :md="24" :lg="24">
        <el-tabs v-model="activeName" class="demo-tabs">
          <el-tab-pane label="待审批" name="first">
            <todo-list active-type="Todo"></todo-list>
          </el-tab-pane>
          <el-tab-pane label="已审批" name="second">
            <todo-list active-type="Approved"></todo-list>
          </el-tab-pane>
        </el-tabs>

      </el-col>
    </el-row>
  </div>
</template>

<script setup name="Index">
import TodoList from "@/views/business/todo/list.vue";
import {getCurrentInstance} from "vue";


const {proxy} = getCurrentInstance();

const version = ref('3.8.4')
const activeName = ref('first')

</script>

<style scoped lang="scss">
.home {
  :deep(.pagination-container .el-pagination){
    right: 10px;
  }


  blockquote {
    padding: 10px 20px;
    margin: 0 0 20px;
    font-size: 17.5px;
    border-left: 5px solid #eee;
  }
  hr {
    margin-top: 20px;
    margin-bottom: 20px;
    border: 0;
    border-top: 1px solid #eee;
  }
  .col-item {
    margin-bottom: 20px;
  }

  ul {
    padding: 0;
    margin: 0;
  }

  font-family: "open sans", "Helvetica Neue", Helvetica, Arial, sans-serif;
  font-size: 13px;
  color: #676a6c;
  overflow-x: hidden;

  ul {
    list-style-type: none;
  }

  h4 {
    margin-top: 0px;
  }

  h2 {
    margin-top: 10px;
    font-size: 26px;
    font-weight: 100;
  }

  p {
    margin-top: 10px;

    b {
      font-weight: 700;
    }
  }

  .update-log {
    ol {
      display: block;
      list-style-type: decimal;
      margin-block-start: 1em;
      margin-block-end: 1em;
      margin-inline-start: 0;
      margin-inline-end: 0;
      padding-inline-start: 40px;
    }
  }
}
</style>
