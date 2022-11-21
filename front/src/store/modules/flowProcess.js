import {reactive, shallowReactive} from "vue";

/**
 *
 * @author xuanzi
 * @date 2022/11/4 16:15
 *
 */

const flowProcess = defineStore(
    'flowProcess',
    {
        state: ()=>(
            {
                nodeMap: new Map(),
                selectedNode: {},
                design: {},
            }
        ),
        actions:{
            loadProcess(val){
                this.design = reactive(val)
            },
        }
    }
)

export default flowProcess