<template>
  <node :show="false" @insertNode="type => $emit('insertNode', type)"/>
</template>

<script>
import Node from './Node'

export default {
  name: "EmptyNode",
  components: {Node},
  data() {
    return {}
  },
  emits:["insertNode"],
  methods: {}
}
</script>

<style scoped>

</style>
