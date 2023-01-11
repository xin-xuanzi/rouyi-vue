<template>
  <div>

    <el-card class="update-log" v-loading="loading" >
      <template v-slot:header>
        <div class="clearfix">
          <div>
            <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="68px">
              <el-form-item label="业务名称" prop="status">
                <el-select v-model="queryParams.businessKey" placeholder="数据状态" clearable>
                  <el-option
                      v-for="dict in businessList"
                      :key="dict.businessCode"
                      :label="dict.businessName"
                      :value="dict.businessCode"
                  />
                </el-select>
              </el-form-item>
              <el-form-item label="审批时间" style="width: 308px">
                <el-date-picker
                    v-model="dateRange"
                    value-format="YYYY-MM-DD"
                    type="daterange"
                    range-separator="-"
                    start-placeholder="开始日期"
                    end-placeholder="结束日期"
                ></el-date-picker>
              </el-form-item>
              <el-form-item>
                <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
                <el-button icon="Refresh" @click="resetQuery">重置</el-button>
              </el-form-item>
            </el-form>
          </div>
          <div>
            <right-toolbar :search="false" @queryTable="getTodoList"></right-toolbar>
          </div>
        </div>

      </template>
      <div class="body">
        <el-table size="default" :data="tableData" style="width: 100%" @row-click="rowClick">
          <el-table-column label="业务编码" prop="businessCode" />
          <el-table-column label="业务名称" prop="businessName"/>
          <el-table-column label="业务ID" prop="caseInstanceId"/>
          <el-table-column label="流程名称" prop="processName" />
          <el-table-column label="提交人" prop="submitUserName" />
          <el-table-column label="部门" prop="deptName" />
          <el-table-column label="通知时间" prop="createTime" />
          <el-table-column label="审批时间" prop="endTime" />
        </el-table>
        <pagination
            v-show="total > 0"
            :total="total"
            v-model:page="queryParams.pageNum"
            v-model:limit="queryParams.pageSize"
            @pagination="jumpPage"
        />
      </div>

    </el-card>
  </div>
</template>

<script setup name="TodoList">
import {queryTodo, queryApproved } from "@/api/flowProcess/flowProcess";
import {getCurrentInstance, reactive} from "vue";
import {businessEnableList} from "@/api/flowProcess/business";
const router = useRouter();
const { proxy } = getCurrentInstance();
const props = defineProps({
  activeType: {
    type: String,
    default:'Todo',
    required: true
  }
})


const tableData = ref([])
const loading = ref(false);
const showSearch = ref(true);
const total = ref(0);
const businessList = ref([]);
const dateRange = ref([]);

const queryParams = reactive({
  businessKey:'',
  beginDate:'',
  endDate:'',
  pageNum:1,
  pageSize:10,
})

function buildQueryParam(){
  if (dateRange.value.length > 0) {
    queryParams.beginDate = dateRange.value[0]
    queryParams.endDate = dateRange.value[1]
  }

  return queryParams
}
function getTodoList(){
  loading.value = true;
  queryTodo(buildQueryParam()).then(res => {
    tableData.value = res.rows;
    total.value = Number(res.total);
    loading.value = false;
  })
}

function getApprovedList(){
  loading.value = true;
  queryApproved(buildQueryParam()).then(res => {
    tableData.value = res.rows;
    total.value = Number(res.total);
    loading.value = false;
  })
}
async function getBusinessType(){
  loading.value = true;
  businessEnableList().then(rsp => {
    businessList.value = rsp.data
  })
}

//页码跳转
function jumpPage() {
  if (props.activeType === 'Todo') {
    getTodoList();
  } else {
    getApprovedList();
  }
}
function handleQuery() {
  jumpPage();
}
function rowClick(row, column, event) {
  router.push("/business/todo/index/" + row.taskId);
}
getBusinessType()
jumpPage()
</script>

<style scoped lang="scss">
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
</style>