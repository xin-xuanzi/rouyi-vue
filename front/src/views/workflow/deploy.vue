<template>
  <div class="app-container">
    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
            type="primary"
            plain
            icon="Plus"
            @click="handleAdd"
        >新增
        </el-button>

      </el-col>

    </el-row>

    <el-card class="box-card" v-for="item in  businesstList" :key="item.id">
      <template #header>
        <div class="card-header">
          <h3>{{ item.name }}</h3>
          <el-button class="button" type="text" icon="Plus" @click="handleAdd">新增流程</el-button>
        </div>
      </template>
      <el-table :data="item.expandProcess" style="width: 100%">
        <el-table-column prop="name" label="名称" width="180"/>
        <el-table-column prop="statusName" label="状态" width="180">
        </el-table-column>
        <el-table-column prop="status" label="启用/停用">
          <template #default="scope">
            <el-switch
                disabled="scope.row.status == '0'"
                v-model="scope.row.status"
                active-value="1"
                inactive-value="0"
                inactive-text="禁用"
                active-text="启动"
            ></el-switch>
          </template>
        </el-table-column>
        <el-table-column prop="version" label="版本"/>
        <el-table-column prop="deployTime" label="部署时间"/>
        <el-table-column prop="createTime" label="创建时间"/>
        <el-table-column label="操作">
          <template #default="scope">
            <el-button type="text" icon="Edit" size="small" @click="edit(scope.row.expandProcessId)">编辑</el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-card>

    <el-dialog v-model="dialogTableVisible"
               :fullscreen="fullscreen" top="5vh"
               :show-close="false"
               :destroy-on-close="true"
    >
      <template #header>
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
    businesstList.value = response.data;
    loading.value = false;
  });
}

function handleAdd() {
  actExpandProcessId.value = null
  dialogTableVisible.value = true;
}

function deploySuccess() {
  dialogTableVisible.value = false;
  getList();
}
function edit(id) {
  actExpandProcessId.value = id
  nextTick(() => {
    dialogTableVisible.value = true;
  })
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

.el-dialog__body {
  padding-top: 5px;
}
</style>