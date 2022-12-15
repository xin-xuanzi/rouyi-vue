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
 * 部署流程
 * @returns
 */
export function queryListByBusiness(business) {
    return request({
        url: '/workflow/' + business,
        method: 'GET',
        data: {}
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
 * 变更流程状态流程
 * @returns
 */
export function changeStatus(data) {
    return request({
        url: '/workflow/changeStatus',
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


/**
 * 查询代办信息
 * @returns
 */
export function queryTodo() {
    return request({
        url: '/workflow/todo',
        method: 'GET',
        params: {}
    })
}



/**
 * 查询代办信息
 * @returns
 */
export function queryTodoDetail(taskId) {
    return request({
        url: '/workflow/todo/' + taskId,
        method: 'GET',
        params: {}
    })
}

/**
 * 查询审批记录
 * @returns
 */
export function queryApprovalRecord(processInstanceId) {
    return request({
        url: '/workflow/approvalRecord/' + processInstanceId,
        method: 'GET',
        params: {}
    })
}
