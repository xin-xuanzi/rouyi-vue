<template>
  <div style="margin-top: 10px">
    <el-tag class="org-item" type="info"
            v-for="(org, index) in _value" :key="index + '_org'"
            closable size="small" @close="removeOrgItem(index)">
      {{ org.nickName }}
    </el-tag>
  </div>
</template>

<script>
export default {
  name: "OrgItems",
  components: {},
  emits:['"update:modelValue'],
  props: {
    modelValue: {
      type: Array,
      default: () => {
        return []
      }
    }
  },
  computed: {
    _value: {
      get() {
        return this.modelValue;
      },
      set(val) {
        this.$emit("update:modelValue", val);
      }
    }
  },
  data() {
    return {}
  },
  methods: {
    removeOrgItem(index) {
      this._value.splice(index, 1)
    }
  }
}
</script>

<style scoped>
.org-item{
  margin: 5px;
}
</style>
