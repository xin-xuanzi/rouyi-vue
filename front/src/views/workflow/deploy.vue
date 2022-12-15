<template>
  <div class="app-container">
    <el-card class="box-card" v-for="item in  businesstList" :key="item.id">
      <template #header>
        <div class="card-header">
          <h3>{{ item.businessName }}</h3>
          <el-button class="button" icon="Plus" @click="handleAdd">新增流程</el-button>
        </div>
      </template>

      <el-table :data="item.expandProcess" style="width: 100%">
        <el-table-column prop="name" label="名称" width="180"/>
        <el-table-column prop="statusName" label="状态" width="180">
        </el-table-column>
        <el-table-column label="启用/停用">
          <template #default="scope">
            <el-switch
                v-if="scope.row.status != 0"
                v-model="scope.row.status"
                active-value="1"
                inactive-value="99"
                inactive-text="停用"
                active-text="启动"
                @change="handleStatusChange(scope.row)"
            ></el-switch>
          </template>
        </el-table-column>
        <el-table-column prop="version" label="版本"/>
        <el-table-column prop="deployTime" label="部署时间"/>
        <el-table-column prop="createTime" label="创建时间"/>
        <el-table-column label="操作">
          <template #default="scope">
            <el-tooltip content="修改"  placement="top" v-if="scope.row.roleId !== 1">
              <el-button
                  :disabled="scope.row.status == '1'"
                  type="text"
                  icon="Edit"
                  @click="handleUpdate(scope.row.expandProcessId)"
                  v-hasPermi="['system:role:edit']"
              ></el-button>
            </el-tooltip>
          </template>
        </el-table-column>
      </el-table>
    </el-card>

    <el-dialog v-model="dialogTableVisible"
               :fullscreen="fullscreen" top="5vh"
               :show-close="false"
               :destroy-on-close="true"
               @closed="closed"
    >
      <template #title>
        <div class="dialog-header">
          <div>设计流程</div>
          <div class="FullScreen">
            <el-icon class="el-dialog__headerbtn" style="right: 45px" size="15px" @click="fullscreen = !fullscreen">
              <FullScreen/>
            </el-icon>
            <el-icon class="el-dialog__headerbtn" size="15px" @click="dialogTableVisible = false">
              <Close/>
            </el-icon>
          </div>
        </div>
      </template>
      <design :fullscreen="fullscreen" @deploySuccess="deploySuccess"
              :act-expand-process-id="actExpandProcessId"/>
    </el-dialog>
  </div>
</template>

<script setup name="Deploy">
import {businessGroup} from "@/api/flowProcess/business";
import Design from "@/views/workflow/design";
import {nextTick} from "vue";
import {changeStatus} from "@/api/flowProcess/flowProcess";
let { proxy } = getCurrentInstance();

const router = useRouter();

const businesstList = ref([]);
const loading = ref(true);
const dialogTableVisible = ref(false)
const fullscreen = ref(false)
const actExpandProcessId = ref(null)

/** 查询部门列表 */
function getList() {
  loading.value = true;
  businessGroup().then(response => {
    console.log(JSON.stringify(response.data))
    businesstList.value = response.data;
    console.log(response.data)
    loading.value = false;
  });
}

function handleAdd() {
  actExpandProcessId.value = null
  dialogTableVisible.value = true;
}
function handleStatusChange(row) {
  let text = row.status === "1" ? "启用" : "停用";
  proxy.$modal.confirm('确认要"' + text + '""' + row.name + '"流程吗?').then(function () {
    return changeStatus({
      expandProcessId: row.expandProcessId,
      status: row.status
    });
  }).then(() => {
    proxy.$modal.msgSuccess(text + "成功");
    row.statusName = text
  }).catch(function () {
    row.status = row.status === "99" ? "1" : "99";
  });
}
function deploySuccess() {
  dialogTableVisible.value = false;
  getList();
}
function handleUpdate(id) {
  actExpandProcessId.value = id
  nextTick(() => {
    dialogTableVisible.value = true;
  })
}
function closed() {
  getList();
}

getList();
</script>

<style lang='scss' scoped>


.card-header h3 {
  display: inline;
}

.card-header .button {
  margin-left: 40px;
}


.dialog-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.el-dialog__headerbtn:hover {
  color: var(--el-menu-hover-text-color);
}

:deep(.el-dialog__body) {
 padding-top: 5px;
}
</style>