<template>
  <div>
    <el-form label-width="100px">
      <el-form-item label="调整优先级" prop="level">
        <el-popover placement="right" title="拖拽条件调整优先级顺序" width="250" trigger="click">
          <template #default>
            <draggable style="width: 100%; min-height:25px" :list="prioritySortList" group="from" :options="sortOption">
              <div :class="{'drag-no-choose': true, 'drag-hover': cd.id === selectedNode.id}"
                   v-for="(cd, index) in prioritySortList">
                <ellipsis style="width: 160px;" hover-tip :content="cd.name"/>
                <div>优先级 {{ index + 1 }}</div>
              </div>
            </draggable>
          </template>
          <template #reference>
            <el-button icon="Sort" >第{{ nowNodeLeave + 1 }}级</el-button>
          </template>
        </el-popover>
      </el-form-item>

      <el-form-item label="条件表达式">
        <div style="width: 100%">
          <el-card class="box-card">
            <div>
              <template v-for="(item,index) in  expression">

                <div>
                  <el-select v-model="item.variableId" class="select-wi" placeholder="变量" size="small" @change="(val) => changeVariable(item, val)">
                    <el-option v-for="item in variables"
                               :label="item.title"
                               :value="item.id"
                    />
                  </el-select>
                  <el-select v-model="item.operator" class="select-wi ml-1" placeholder="运算符" size="small">
                    <el-option v-for="item in operator"
                               :label="item.label"
                               :value="item.value"
                    />
                  </el-select>
                  <el-input size="small" v-model="item.value" class="select-wi ml-1" placeholder="value" />
                  <el-tooltip content="删除" placement="top">
                    <el-button
                        style="color:red;margin-left: 0.5rem;font-size: 16px"
                        type="text"
                        icon="CloseBold"
                        @click="delOperator(index)"
                    ></el-button>
                  </el-tooltip>
                </div>
                <div class="text-center" v-if="index !== (expression.length -1)">
                  <el-switch v-model="item.groupType" active-color="#409EFF"
                             inactive-color="#c1c1c1" active-value="AND"
                             inactive-value="OR"
                             active-text="且" inactive-text="或"/>
                </div>
              </template>
            </div>

            <div class="text-center">
              <el-button type="primary" icon="Plus" size="small" @click="addOperator"/>
            </div>
          </el-card>
        </div>
      </el-form-item>
    </el-form>

  </div>
</template>

<script>
import {queryByBusiness} from "@/api/flowProcess/variable";
import { VueDraggableNext } from 'vue-draggable-next'
import GroupItem from "./ConditionGroupItemConfig.vue"
import flowProcess from "@/store/modules/flowProcess";
import Ellipsis from "@/components/Common/Ellipsis";
export default {
  name: "ConditionNodeConfig",
  components: {
    draggable: VueDraggableNext,
    GroupItem,
    Ellipsis},
  props: {
    config: {
      type: Object,
      default: () => {
        return {}
      }
    }
  },
  computed: {
    nodeProps() {
      return flowProcess().selectedNode.props
    },
    setup() {
      return flowProcess().design
    },
    selectedNode() {
      return flowProcess().selectedNode
    },
    select() {
      return this.config.assignedUser || []
    },
    nowNodeLeave() {
      return this.prioritySortList.indexOf(this.selectedNode)
    },
    expression() {
      return flowProcess().selectedNode.props.groups
    },
    //条件节点
    prioritySortList() {
      let node = flowProcess().nodeMap.get(this.selectedNode.parentId)
      if (node) {
        return node.branchs || []
      }
      return []
    }
  },
  data() {
    return {
      sortOption: {
        animation: 300,
        chosenClass: 'choose',
        scroll: true,
        sort: true
      },
      variables:[],
      operator:[
        {label:'=',value:'='},
        {label:'>',value:'>'},
        {label:'<',value:'<'},
        {label:'≤',value:'<='},
        {label:'≥',value:'>='},
        {label:'≠',value:'!='},
      ],
    }
  },
  mounted() {
    queryByBusiness(this.setup.businessCode).then(res => {
      this.variables = res.data;
    })
  },
  methods: {

    selected(select) {
      console.log(select)
      this.showOrgSelect = false
      select.forEach(val => this.select.push(val))
    },
    removeOrgItem(index) {
      this.select.splice(index, 1)
    },

    changeVariable(item, vId){
      const obj = this.variables.find(item => item.id === vId);
      item.variableTitle = obj.title
      item.variableCode = obj.code
    },
    addOperator(){
      this.nodeProps.groups.push(
          {
            variableId:'',
            variableTitle:'',
            operator: '',
            value: '',
            groupType: 'OR',
          }
      )
    },
    delOperator(index) {
      this.expression.splice(index, 1)
    }
  }
}
</script>

<style lang="scss" scoped>
.choose {
  border-radius: 5px;
  margin-top: 2px;
  background: #f4f4f4;
  border: 1px dashed #1890FF !important;
}

.drag-hover {
  color: #1890FF
}

.box-card{
  //display: flex;
  //align-items: center;
}

.select-wi{
  width: 29%;
}
.ml-1{
  margin-left: .5rem;
}
.drag-no-choose {
  cursor: move;
  background: #f8f8f8;
  border-radius: 5px;
  margin: 5px 0;
  height: 40px;
  line-height: 25px;
  padding: 5px 10px;
  border: 1px solid #ffffff;
  div{
    display: inline-block;
    font-size: small !important;
  }

  div:nth-child(2) {
    float: right !important;
  }
}
</style>
