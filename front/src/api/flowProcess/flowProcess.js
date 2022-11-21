import request from "@/utils/request";
/**
 *
 * @author xuanzi
 * @date 2022/11/4 16:41
 *
 */

export function defaultProcess() {
    return {
        "id": "root",
        "parentId": null,
        "type": "ROOT",
        "name": "发起人",
        "desc": "发起人",
        "props": {
            "assignedUser": [],
            "formPerms": []
        },
        "children": {
            "id": "node_end_123",
            "type": "END",
            "children": {}
        }
    }
}


/**
 * 部署流程
 * @returns
 */
export function deploy(data) {
    return request({
        url: '/workflow/deploy',
        method: 'POST',
        data: data
    })
}

/**
 * 保存流程
 * @returns
 */
export function save(data) {
    return request({
        url: '/workflow/save',
        method: 'POST',
        data: data
    })
}


/**
 * 查询流程
 * @returns
 */
export function detail(id) {
    return request({
        url: '/workflow/detail/' + id,
        method: 'GET',
        params: {}
    })
}
