<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" v-show="showSearch" :inline="true">
      <el-form-item label="申请人名称" prop="condition">
        <el-input
            v-model="queryParams.condition"
            placeholder="请输入申请人名称"
            clearable
            style="width: 240px"
            @keyup.enter="handleQuery"
        />
      </el-form-item>

      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>
    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
            type="primary"
            plain
            icon="Plus"
            @click="handleAdd"
            v-hasPermi="['system:role:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
            type="success"
            plain
            icon="Edit"
            :disabled="single"
            @click="handleUpdate"
            v-hasPermi="['system:role:edit']"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
            type="danger"
            plain
            icon="Delete"
            :disabled="multiple"
            @click="handleDelete"
            v-hasPermi="['system:role:remove']"
        >删除</el-button>
      </el-col>
<!--      <el-col :span="1.5">-->
<!--        <el-button-->
<!--            type="warning"-->
<!--            plain-->
<!--            icon="Download"-->
<!--            @click="handleExport"-->
<!--            v-hasPermi="['system:role:export']"-->
<!--        >导出</el-button>-->
<!--      </el-col>-->
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <!-- 表格数据 -->
    <el-table v-loading="loading" :data="dataList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="请假编号" prop="id"  />
      <el-table-column label="申请人" prop="userName"  />
      <el-table-column label="开始日期" prop="startDate" >
        <template #default="scope">
          {{scope.row.startDate}}
          <el-tag>
            {{scope.row.startTime === 'AM'?'上午':'下午'}}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="结束时间" prop="endDate"  >
        <template #default="scope">
          {{scope.row.endDate}}
          <el-tag>
          {{scope.row.endTime === 'AM'?'上午':'下午'}}
        </el-tag>
        </template>
      </el-table-column>

      <el-table-column label="请假天数" prop="duration" align="center" width="100"></el-table-column>
      <el-table-column label="状态" prop="status" align="center" width="100"></el-table-column>
      <el-table-column label="创建时间" align="center" prop="createTime">
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-tooltip content="修改" placement="top" v-if="scope.row.roleId !== 1">
            <el-button
                type="text"
                icon="Edit"
                @click="handleUpdate(scope.row)"
                v-hasPermi="['system:role:edit']"
            ></el-button>
          </el-tooltip>

        </template>
      </el-table-column>
    </el-table>

    <pagination
        v-show="total > 0"
        :total="total"
        v-model:page="queryParams.pageNum"
        v-model:limit="queryParams.pageSize"
        @pagination="getList"
    />

    <el-dialog title="请假申请" v-model="open" width="600px" append-to-body>
      <el-form ref="leaveRef" :model="form" :rules="rules" label-width="100px">
        <el-form-item label="审批流程" prop="processDefinitionId">
          <el-select v-model="form.processDefinitionId">
            <el-option v-for="item in processList" :label="item.name" :value="item.actProcessId"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="请假类型" prop="leaveType">
          <el-select v-model="form.leaveType">
            <el-option v-for="item in leaveTypes" :label="item.title" :value="item.value"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="开始时间" prop="startDate">
          <el-date-picker
              v-model="form.startDate"
              value-format="YYYY-MM-DD"
              type="date"
              placeholder="开始日期"
          ></el-date-picker>

          <el-select
              placeholder="开始时间"
              v-model="form.startTime"
              style="width:130px;margin-left: 5px"
          >
            <el-option label="上午" value="AM"></el-option>
            <el-option label="下午" value="PM"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="结束时间" prop="endDate">
          <el-date-picker
              v-model="form.endDate"
              value-format="YYYY-MM-DD"
              type="date"
              placeholder="结束日期"
          ></el-date-picker>
          <el-select
              placeholder="结束时间"
              v-model="form.endTime"
              style="width:130px;margin-left: 5px"
          >
            <el-option label="上午" value="AM"></el-option>
            <el-option label="下午" value="PM"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="请假天数">
          <el-input v-model="duration" placeholder="请假天数" readonly/>
        </el-form-item>
        <el-form-item label="备注">
          <el-input v-model="form.remark" type="textarea" placeholder="请输入内容"></el-input>
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitForm">确 定</el-button>
          <el-button @click="cancel">取 消</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup name="Leave">
import {getCurrentInstance, ref, toRefs} from "vue";
import {queryListByBusiness} from "@/api/flowProcess/flowProcess";
import {listLeave, leaveSubmit} from "@/api/business/leave";
import {dateDiff} from "@/utils/ruoyi";
const {proxy} = getCurrentInstance()
const businessCode = "LEAVE";
const total = ref(0);
const loading = ref(false);
const open = ref(false);
const showSearch = ref(false);
const multiple = ref(false);
const single = ref(false);

const leaveTypes = ref([
  {value:1, title:"年休假"},
  {value:2, title:"产假"},
  {value:3, title:"事假"},
])
const dataList = ref([]);
const processList = ref([]);
const data = reactive({
  form: {},
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    roleName: undefined,
    roleKey: undefined,
    status: undefined
  },
  rules: {
    processDefinitionId: [{ required: true, message: "请假流程不能为空", trigger: "change" }],
    leaveType: [{ required: true, message: "请假类型不能为空", trigger: "change" }],
    startDate: [{ validator: validateStartDateTime, trigger: "change" },{ required: true, message: "开始日期不能为空", trigger: "change" }],
    endDate: [{ validator: validateEndDateTime, trigger: "change" },{ required: true, message: "结束日期不能为空", trigger: "change" }],
  },
});

const {form, queryParams, rules} = toRefs(data);

const duration = computed(() => {
  if (!form.value.startDate || !form.value.startTime
      || !form.value.endTime || !form.value.endDate) {
    return 0
  }
  if (form.value.startDate === form.value.endDate && form.value.startTime > form.value.endTime) {
    return 0
  }
  if (form.value.startDate === form.value.endDate ) {
    if (form.value.startTime === form.value.endTime) {
      return 0.5
    }
    return 1
  }

  let duration = dateDiff(form.value.startDate, form.value.endDate);
  if (duration > 0 && form.value.endTime === form.value.startTime) {
    duration += 0.5
  }
  if (duration > 0 && form.value.endTime > form.value.startTime) {
    duration += 1
  }

  return duration
})

function resetFrom() {
  form.value = {
    processDefinitionId:undefined,
    leaveType:undefined,
    startDate:undefined,
    startTime:undefined,
    endDate:undefined,
    endTime:undefined,
    duration:0,
  }
  proxy.resetForm("leaveRef");
}
function handleSelectionChange() {}
function handleQuery() {}
function resetQuery() {}
function handleAdd() {
  resetFrom();
  open.value = true
}
function handleDelete() {}
function handleUpdate() {}
function submitForm() {
  proxy.$refs["leaveRef"].validate(valid => {
    if (valid) {
      form.value.duration = duration
      leaveSubmit(form.value).then(response => {
        proxy.$modal.msgSuccess("新增成功");
        open.value = false;
        getList();
      });
    }
  });
}
function cancel() {
  open.value = false;
}
function getList() {
  listLeave(queryParams).then(res => {
    dataList.value = res.rows
    total.value = Number(res.total)
  })
}

function validateStartDateTime(rule, value, callback) {
  if (!value || value === ''
    || !form.value.startTime|| form.value.startTime === '') {
    callback(new Error('请选择开始日期和开始时间'))
  } else {
    callback()
  }
}
function validateEndDateTime(rule, value, callback) {
  if (!value || value === ''
      || !form.value.endTime|| form.value.endTime === '') {
    callback(new Error('请选择结束日期和结束时间'))
    return;
  }

  if (value < form.value.startDate) {
    callback(new Error('请选择结束日期不能小于开始日期'))
    return;
  }
  callback()
}

async function getProcessList() {
  queryListByBusiness(businessCode).then(res => {
    processList.value = res.data
  })
}
getProcessList()
getList()
</script>

<style scoped>

</style>