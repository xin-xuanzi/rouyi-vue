<template>
  <div class="app-container home">

    <el-row :gutter="20">
      <el-col :xs="24" :sm="24" :md="24" :lg="24">
        <el-card class="update-log" v-loading="loading">
          <template v-slot:header>
            <div class="clearfix">
              <div>
                <span>代办</span>
              </div>

              <div>
                <right-toolbar :search="false" @queryTable="getTodoList"></right-toolbar>
              </div>
            </div>

          </template>
          <div class="body">
            <el-table :data="tableData" style="width: 100%" @row-click="rowClick">
              <el-table-column label="业务编码" prop="businessCode" />
              <el-table-column label="业务名称" prop="businessName"/>
              <el-table-column label="业务ID" prop="caseInstanceId"/>
              <el-table-column label="流程名称" prop="processName" />
              <el-table-column label="提交人" prop="submitUserName" />
              <el-table-column label="部门" prop="deptName" />
              <el-table-column label="通知时间" prop="createTime" />
            </el-table>
          </div>

          <pagination
              v-show="total > 0"
              :total="total"
              v-model:current-page="queryParams.pageNum"
              v-model:page-size="queryParams.pageSize"
              @pagination="getTodoList"
          />

        </el-card>


      </el-col>
    </el-row>
  </div>
</template>

<script setup name="Index">
import {queryTodo} from "@/api/flowProcess/flowProcess";
import {getCurrentInstance, reactive} from "vue";
const router = useRouter();

const {proxy} = getCurrentInstance();
const tableData = ref([])
const loading = ref(false);
const showSearch = ref(true);
const total = ref(0);
const version = ref('3.8.4')
const queryParams = reactive({
  pageNum:1,
  pageSize:10,
})
function getTodoList(){
  loading.value = true;
  queryTodo().then(res => {
    tableData.value = res.rows;
    total.value = Number(res.total);
    loading.value = false;
  })
}


function rowClick(row, column, event) {
  router.push("/business/todo/index/" + row.taskId);
}

getTodoList();
</script>

<style scoped lang="scss">
.home {
  :deep(.pagination-container .el-pagination){
    right: 10px;
  }

  .clearfix{
    display: flex;
    align-items: center;
    justify-content: space-between;
    div:first-child{
      flex: 23;
      font-size: 17px;
      font-weight: 500;
    }
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
