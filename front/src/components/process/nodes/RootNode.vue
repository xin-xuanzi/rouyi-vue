<template>
  <node title="发起人" :is-root="true" :content="content"
        @selected="$emit('selected')" @insertNode="insertNode"
        placeholder="发起人" header-bgc="#576a95" header-icon="UserFilled"/>
</template>

<script>
import Node from './Node'

export default {
  name: "RootNode",
  components: {Node},
  emits:["insertNode"],
  props:{
    config:{
      type: Object,
      default: () => {
        return {}
      }
    }
  },
  computed:{
    content(){
      if (this.config.props.assignedUser.length > 0){
        let texts = []
        this.config.props.assignedUser.forEach(org => texts.push(org.name))
        return String(texts).replaceAll(',', '、')
      } else {
        return '所有人'
      }
    }
  },
  data() {
    return {
    }
  },
  methods: {
    insertNode( type){
      this.$emit('insertNode', type)
    }
  }
}
</script>

<style scoped>

</style>
