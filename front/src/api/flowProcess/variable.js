/**
 * 流程变量 API
 * @author xuanzi
 * @date 2022/12/1 11:36
 *
 */

import request from "@/utils/request";

// 查询 流程变量
export function queryPage(query) {
    return request({
        url: '/workflow/variable/page',
        method: 'get',
        params: query
    })
}

// 查询 流程变量执行方法
export function queryMethods() {
    return request({
        url: '/workflow/variable/methods',
        method: 'get',
        params: {}
    })
}


// 查询 流程变量详情
export function queryDetail(id) {
    return request({
        url: '/workflow/variable/detail/' + id,
        method: 'get',
        params: {}
    })
}

// 保存 流程变量执行方法
export function saveOrUpdate(data) {
    return request({
        url: '/workflow/variable/saveOrUpdate',
        method: 'POST',
        data: data
    })
}


// 查询 流程变量执行方法
export function queryByBusiness(businessCode) {
    return request({
        url: '/workflow/variable/business/' + businessCode,
        method: 'GET',
        params: {}
    })
}