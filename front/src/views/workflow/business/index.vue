<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" v-show="showSearch" :inline="true">
      <el-form-item label="名称" prop="roleName">
        <el-input
            v-model="queryParams.condition"
            placeholder="请输入名称"
            clearable
            style="width: 240px"
            @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-select
            v-model="queryParams.status"
            placeholder="状态"
            clearable
            style="width: 240px"
        >
          <el-option
              v-for="dict in sys_normal_disable"
              :key="dict.value"
              :label="dict.label"
              :value="dict.value"
          />
        </el-select>
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
<!--      <el-col :span="1.5">-->
<!--        <el-button-->
<!--            type="danger"-->
<!--            plain-->
<!--            icon="Delete"-->
<!--            :disabled="multiple"-->
<!--            @click="handleDelete"-->
<!--        >删除</el-button>-->
<!--      </el-col>-->
      <el-col :span="1.5">
        <el-button
            type="warning"
            plain
            icon="Download"
            @click="handleExport"
        >导出</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>
    <el-table v-loading="loading" :data="dataList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="业务编号" prop="businessCode" width="150" />
      <el-table-column label="业务名称" prop="businessName" />
      <el-table-column label="组件路径" prop="viewPath"/>
      <el-table-column label="流程变量"  align="center" :show-overflow-tooltip="true">
        <template #default="scope">
          <div v-for="item in scope.row.variables">
            <el-tag class="ml-2" >{{item.title}}-{{item.code}}</el-tag>
          </div>

        </template>

      </el-table-column>
      <el-table-column label="状态" align="center">
        <template #default="scope">
          <el-switch
              v-model="scope.row.status"
              active-value="0"
              inactive-value="1"
              @change="handleStatusChange(scope.row)"
          ></el-switch>
        </template>
      </el-table-column>
      <el-table-column label="创建时间" align="center" prop="createTime">
        <template #default="scope">
          <span>{{ scope.row.createTime }}</span>
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
<!--          <el-tooltip content="删除" placement="top" v-if="scope.row.roleId !== 1">-->
<!--            <el-button-->
<!--                type="text"-->
<!--                icon="Delete"-->
<!--                @click="handleDelete(scope.row)"-->
<!--                v-hasPermi="['system:role:remove']"-->
<!--            ></el-button>-->
<!--          </el-tooltip>-->
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
      <el-form ref="businessRef" :model="form" :rules="rules" label-width="100px">
        <el-form-item label="业务编码" prop="businessCode">
          <el-input v-model="form.businessCode" placeholder="请输入业务编码" />
        </el-form-item>
        <el-form-item label="名称" prop="businessName">
          <el-input v-model="form.businessName" placeholder="请输入业务名称" />
        </el-form-item>
        <el-form-item label="组件地址" prop="businessName">
          <template #label>
                        <span>
                           <el-tooltip content="访问的组件路径，如：`system/user/detail`，默认在`views`目录下" placement="top">
                              <el-icon><question-filled /></el-icon>
                           </el-tooltip>
                           组件地址
                        </span>
          </template>
          <el-input v-model="form.viewPath" placeholder="请输入组件地址" />
        </el-form-item>
        <el-form-item label="流程变量" prop="businessName">
          <el-card class="box-card" shadow="hover" @click="showVariablePicker()">
            <el-empty :image-size="80" description="请点击添加流程变量" v-show="form.variables.length === 0"/>
            <div v-for="(item, index) in form.variables" >
              <el-tag>{{item.title}}-{{item.code}}</el-tag>
            </div>

          </el-card>
        </el-form-item>

      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitForm()">确 定</el-button>
          <el-button @click="cancel">取 消</el-button>
        </div>
      </template>
    </el-dialog>

    <org-picker title="选择流程变量" multiple type="variable" ref="orgPicker" :selected="variableSelected"
                @ok="selected"/>
  </div>
</template>
<script setup name="Business">
import {computed, getCurrentInstance, reactive, ref, toRefs} from "vue";
import {businessAllList, businessDetail,changeBusinessStatus, businessSaveOrUpdate} from "@/api/flowProcess/business";
import OrgPicker from "@/components/Common/OrgPicker.vue";

const { proxy } = getCurrentInstance();
const { sys_normal_disable } = proxy.useDict("sys_normal_disable");

const dataList = ref([]);
const showSearch = ref(true);
const loading = ref(false);
const single = ref(true);
const multiple = ref(true);
const open = ref(false);
const variableSelected = ref([]);
const ids = ref([]);
const total = ref(0);
const title = ref("新增业务编码");
const orgPickerSelected = computed(() => {
  return []
})

const data = reactive({
  form: {
    variables:[]
  },
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    roleName: undefined,
    roleKey: undefined,
    status: undefined
  },
  rules: {
    roleName: [{ required: true, message: "角色名称不能为空", trigger: "blur" }],
    roleKey: [{ required: true, message: "权限字符不能为空", trigger: "blur" }],
    roleSort: [{ required: true, message: "角色顺序不能为空", trigger: "blur" }]
  },
});

const { queryParams, form, rules } = toRefs(data);

/** 查询角色列表 */
function getList() {
  loading.value = true;
  businessAllList(queryParams.value).then(response => {
    dataList.value = response.rows;
    total.value = Number(response.total);
    loading.value = false;
  });
}

function handleQuery(){
  queryParams.value.pageNum = 1;
  getList();
}

/** 重置按钮操作 */
function resetQuery() {
  proxy.resetForm("queryRef");
  handleQuery();
}

/** 多选框选中数据 */
function handleSelectionChange(selection) {
  ids.value = selection.map(item => item.id);
  single.value = selection.length != 1;
  multiple.value = !selection.length;
}

function handleAdd() {
  reset();
  open.value = true;
  title.value = "添加业务编码";
}
/** 修改角色 */
function handleUpdate(row) {

  const id = row.id || ids.value;
  reset();
  businessDetail(id).then(res => {
    form.value = res.data
    open.value = true
  })
}

/** 删除按钮操作 */
function handleDelete(row) {
  // const roleIds = row.roleId || ids.value;
  // proxy.$modal.confirm('是否确认删除角色编号为"' + roleIds + '"的数据项?').then(function () {
  //   return delRole(roleIds);
  // }).then(() => {
  //   getList();
  //   proxy.$modal.msgSuccess("删除成功");
  // }).catch(() => {});
}
/** 导出按钮操作 */
function handleExport() {
  // proxy.download("system/role/export", {
  //   ...queryParams.value,
  // }, `role_${new Date().getTime()}.xlsx`);
}

function handleStatusChange(row) {
  let text = row.status === "0" ? "启用" : "停用";
  proxy.$modal.confirm('确认要"' + text + '" "' + row.businessName + '"业务编码吗?').then(function () {
    return changeBusinessStatus(row.id, row.status);
  }).then(() => {
    proxy.$modal.msgSuccess(text + "成功");
  }).catch(function () {
    row.status = row.status === "0" ? "1" : "0";
  });
}
function reset() {
  form.value = {
    businessCode:undefined,
    businessName:undefined,
    viewPath:undefined,
    status:'0',
    variables:[],
  }

  proxy.resetForm("businessRef");
}
function cancel() {
  open.value = false
}
function submitForm() {
  proxy.$refs["businessRef"].validate(valid => {
    if (valid) {
      businessSaveOrUpdate(form.value).then(response => {
        proxy.$modal.msgSuccess("提交成功");
        open.value = false;
        getList();
      });
    }
  });
}

function showVariablePicker() {
  variableSelected.value = form.value.variables

  nextTick(() =>{
    proxy.$refs.orgPicker.show();
  })
}
function selected(select) {
  form.value.variables = [...select]

}


getList();
</script>

<style scoped>
.box-card{
  width: 100%;
}

.ml-2 {
  margin-left: 0.5rem;;
}
</style>