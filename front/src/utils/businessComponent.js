/**
 *
 * @author xuanzi
 * @date 2022/12/13 10:08
 *
 */
import {listJobLog} from "@/api/monitor/jobLog";

const modules = import.meta.glob('../views/business/*/*.vue');
// 上面的结果是一个对象，相当于
import request from "@/utils/request";


var result = async ()=> {
    let component = {};
    let res = await request({
        url: '/workflow/business/list',
        method: 'get',
        params: {}
    })
    let list = res.data;

    for (let i = 0; i < list.length; i++) {
        let com, path;
        com = list[i]
        component[com.businessCode] = modules[`../views/${com.viewPath}.vue`]//注意要点
    }

    return component

}//立即执行函数
export default await result()
