<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" v-show="showSearch" :inline="true">
      <el-form-item label="名称" prop="roleName">
        <el-input
            v-model="queryParams.condition"
            placeholder="请输入名称/描述"
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
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
            type="success"
            plain
            icon="Edit"
            :disabled="single"
            @click="handleUpdate"

        >修改</el-button>
      </el-col>

      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>
    <el-table v-loading="loading" :data="dataList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="code" prop="code" />
      <el-table-column label="名称" prop="title"   />
      <el-table-column label="描述" prop="description" :show-overflow-tooltip="true" />
      <el-table-column label="执行调用" prop="invokeTarget" />

      <el-table-column label="创建时间" align="center" prop="createTime">
        <template #default="scope">
          <span>{{ parseTime(scope.row.createTime) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="更新时间" align="center" prop="createTime">
        <template #default="scope">
          <span>{{ parseTime(scope.row.updateTime) }}</span>
        </template>
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

    <!-- 添加或修改变量配置对话框 -->
    <el-dialog :title="title" v-model="open" width="500px" append-to-body>
      <el-form ref="variableRef" :model="form" :rules="rules" label-width="100px">
        <el-form-item label="变量代码" prop="code">
          <el-input v-model="form.code" placeholder="请输入变量代码" />
        </el-form-item>
        <el-form-item label="名称" prop="title">
          <el-input v-model="form.title" placeholder="请输入变量名称" />
        </el-form-item>

        <el-form-item label="调用方法" prop="invokeTarget">
          <el-select v-model="form.invokeTarget" class="m-2" placeholder="调用执行方法">
            <el-option
                v-for="item in methods"
                :key="item"
                :label="item"
                :value="item"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="描述">
          <el-input v-model="form.description" type="textarea" placeholder="请输入内容"></el-input>
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitForm()">确 定</el-button>
          <el-button @click="cancel">取 消</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup name="Variable">
import {queryPage, queryMethods, queryDetail, saveOrUpdate} from "@/api/flowProcess/variable";
const { proxy } = getCurrentInstance();

const open = ref(false);
const showSearch = ref(false);
const multiple = ref(true);
const single = ref(true);
const loading = ref(false);
const dataList = ref([]);
const methods = ref([]);
const total = ref(0);
const title = ref("新增变量");
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
    code: [{ required: true, message: "变量代码不能为空", trigger: "blur" }],
    title: [{ required: true, message: "变量名称不能为空", trigger: "blur" }],
    invokeTarget: [{ required: true, message: "方法调用不能为空", trigger: "blur" }]
  },
})

const {form, queryParams, rules} = toRefs(data);

function getList() {
  loading.value = true;
  queryPage(queryParams).then(res => {
    dataList.value = res.rows;
    total.value = Number(res.total);
    loading.value = false;
  })

  queryMethods().then(res => {
    methods.value = res.data;
  })
}
async function getMethods(){
  queryMethods().then(res => {
    methods.value = res.data;
  })
}

/** 重置新增的表单以及其他数据  */
function reset() {
  form.value = {
    code: '',
    title: '',
    invokeTarget: '',
    description: '',
    status: "0",
  };
  proxy.resetForm("variableRef");
}
function handleQuery() {
  queryParams.value.pageNum = 1;
  getList();
}

function resetQuery() {

}
function handleAdd() {
  reset();
  open.value = true
}

function handleUpdate(row) {
  open.value = true;
  queryDetail(row.id).then(res => {
    form.value = res.data
  })
}

function handleDelete() {

}
function handleSelectionChange() {

}
function submitForm() {
  proxy.$refs["variableRef"].validate(valid => {
    if (valid) {
      saveOrUpdate(form.value).then(response => {
        proxy.$modal.msgSuccess("修改成功");
        open.value = false;
        getList();
      });
    }
  });
}
function cancel() {
  open.value = false
}

getMethods();
getList()
</script>