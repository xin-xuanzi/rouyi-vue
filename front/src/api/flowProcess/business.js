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


// 查询 流程业务list
export function businessAllList(params) {
    return request({
        url: '/workflow/business/page',
        method: 'get',
        params: params
    })
}

/**
 * 查询业务编码详情
 * @param id
 * @returns {*}
 */
export function businessDetail(id) {
    return request({
        url: '/workflow/business/detail/' + id,
        method: 'get',
        params: {}
    })
}

/**
 * 查询业务编码详情
 * @param id
 * @returns {*}
 */
export function businessSaveOrUpdate(data) {
    return request({
        url: '/workflow/business/saveOrUpdate',
        method: 'POST',
        data: data
    })
}

/**
 * 查询业务编码详情
 * @param id
 * @returns {*}
 */
export function changeBusinessStatus(id, status) {
    return request({
        url: '/workflow/business/changeStatus',
        method: 'POST',
        data: {
            id,
            status,
        }
    })
}

export async function businessComponents() {
 let res =  await request({
        url: '/workflow/business/list',
        method: 'get',
        params: {}
    })

    let arr = res.data;
    component = []
    for (let i = 0; i < arr.length; i++) {
        const {businessCode, viewPath} = arr[i]
        component[businessCode] = ()=>import(`@/view/${viewPath}`)
    }

    return component
}