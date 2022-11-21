<template>

  <el-main :class="elMainClass">
    <div class="scale">
      <el-button icon="Plus" size="small" @click="scale += 10" :disabled="scale >= 150" circle></el-button>
      <span>{{ scale }}%</span>
      <el-button icon="minus" size="small" @click="scale -= 10" :disabled="scale <= 40" circle></el-button>
      <!--      <el-button @click="validate">校验流程</el-button>-->
    </div>
    <div class="design" :style="'transform: scale('+ scale / 100 +');'">
      <process-tree ref="process-tree" @selectedNode="nodeSelected"/>
    </div>
    <el-drawer v-model="showConfig"
               :append-to-body="false"
               :close-on-click-modal="false"
               :size="selectedNode.type === 'CONDITION' ? '600px':'500px'"
               direction="rtl"
               destroy-on-close>
      <template #header>
        <div>
          <el-input v-model="selectedNode.name" size="default" v-show="showInput"
                    style="width: 300px" @blur="showInput = false"></el-input>
          <el-link v-show="!showInput" @click="showInput = true" style="font-size: medium">
            <el-icon style="margin-right: 10px">
              <Edit/>
            </el-icon>
            {{ selectedNode.name }}
          </el-link>
        </div>

      </template>
      <div class="node-config-content">
        <node-config/>
      </div>
    </el-drawer>
  </el-main>
</template>

<script>
import ProcessTree from './process/ProcessTree.vue'
import NodeConfig from '@/components/process/config/NodeConfig'
import flowProcess from "@/store/modules/flowProcess";
import {Calendar, Edit, Plus} from "@element-plus/icons-vue";

export default {
  name: "ProcessDesign",
  components: {Edit, Plus, Calendar, ProcessTree, NodeConfig},
  props:{
    fullscreen:{
      type:Boolean,
      default:false,
    }
  },
  data() {
    return {
      scale: 100,
      selected: {},
      showInput: false,
      showConfig: false
    }
  },
  computed: {
    selectedNode() {
      return flowProcess().selectedNode
    },
    elMainClass(){
      return this.fullscreen?'el-main-fullscreen':'el-main';
    },
  },
  mounted() {

  },
  methods: {
    validate() {
      return this.$refs["process-tree"].validateProcess()
    },
    nodeSelected(node) {
      this.showConfig = true
    }
  },
  watch: {
    selectedNode: {
      deep: true,
      handler(node) {
        this.$refs["process-tree"].nodeDomUpdate(node)
      }
    }
  }
}
</script>

<style lang="scss" scoped>
.el-main {
  height: calc(100vh - 300px);
  background-color: #f5f6f6;
}
.el-main-fullscreen {
  height: calc(100vh - 195px);
  background-color: #f5f6f6;
}

.design {
  margin-top: 30px;
  display: flex;
  transform-origin: 50% 0px 0px;
  box-sizing: initial;
}

.scale {
  z-index: 999;
  position: absolute;
  top: 160px;
  right: 65px;

  span {
    margin: 0 10px;
    font-size: 15px;
    color: #7a7a7a;
    width: 50px;
  }
}

.node-config-content {
  padding: 0 20px 20px;
}

:deep(.el-drawer__body) {
  overflow-y: auto;
}
</style>
