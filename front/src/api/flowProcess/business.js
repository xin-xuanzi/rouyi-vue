import request from "@/utils/request";

/**
 *
 * @author xuanzi
 * @date 2022/11/18 15:26
 *
 */

// 查询 流程业务分组
export function businessGroup(query) {
    return request({
        url: '/workflow/business/group',
        method: 'get',
        params: query
    })
}


// 查询 流程业务list
export function businessEnableList() {
    return request({
        url: '/workflow/business/list',
        method: 'get',
        params: {status:0}
    })
}

