<template>
  <div>
    <component :is="(selectNode.type||'').toLowerCase()"  :config="selectNode.props"/>
  </div>
</template>

<script>
import Approval from './ApprovalNodeConfig.vue'
import Condition from './ConditionNodeConfig.vue'
import Delay from './DelayNodeConfig.vue'
import Cc from './CcNodeConfig.vue'
import Trigger from './TriggerNodeConfig.vue'
import FormAuthorityConfig from './FormAuthorityConfig.vue'
import Root from './RootNodeConfig.vue'
import flowProcess from "@/store/modules/flowProcess";

export default {
  name: "NodeConfig",
  components: {
    Approval,
    Condition,
    Trigger,
    Delay,
    Root,
    Cc,
    FormAuthorityConfig
  },
  data() {
    return {
      active: 'properties',
    }
  },
  computed: {
    selectNode() {
      return flowProcess().selectedNode
    },
    formConfig() {
      return flowProcess().design.formItems
    },
    name() {
      console.log('1',this.selectNode)
      switch (this.selectNode.type) {
        case 'ROOT':
          return '设置发起人';
        case 'APPROVAL':
          return '设置审批人';
        case 'CC':
          return '设置抄送人';
        default:
          return null;
      }
    }
  },
  mounted() {
    nextTick(() =>{
      this.$modal.closeLoading();
    })
  },
  methods: {}
}
</script>

<style lang="scss" scoped>

</style>
