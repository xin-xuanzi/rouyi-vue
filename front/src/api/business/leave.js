/**
 *
 * @author xuanzi
 * @date 2022/12/8 17:15
 *
 */

import request from '@/utils/request'

/**
 * 查询 请假信息
 * @param query
 * @returns {*}
 */
export function listLeave(query) {
    return request({
        url: '/leave/page',
        method: 'get',
        params: query
    })
}


/**
 * 查询 请假详情
 * @param query
 * @returns {*}
 */
export function leaveDetail(id) {
    return request({
        url: '/leave/detail/' + id,
        method: 'get',
        params: {}
    })
}


/**
 * 提交请假
 * @param query
 * @returns {*}
 */
export function leaveSubmit(data) {
    return request({
        url: '/leave/submit',
        method: 'POST',
        data: data
    })
}
