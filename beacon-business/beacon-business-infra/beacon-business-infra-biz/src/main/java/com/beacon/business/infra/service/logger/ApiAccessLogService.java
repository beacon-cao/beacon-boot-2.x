package com.beacon.business.infra.service.logger;

import com.beacon.framework.common.pojo.PageResult;
import com.beacon.business.infra.api.logger.dto.ApiAccessLogCreateReqDTO;
import com.beacon.business.infra.controller.admin.logger.vo.apiaccesslog.ApiAccessLogExportReqVO;
import com.beacon.business.infra.controller.admin.logger.vo.apiaccesslog.ApiAccessLogPageReqVO;
import com.beacon.business.infra.dal.dataobject.logger.ApiAccessLogDO;

import java.util.List;

/**
 * API 访问日志 Service 接口
 *
 * @author Beacon
 */
public interface ApiAccessLogService {

    /**
     * 创建 API 访问日志
     *
     * @param createReqDTO API 访问日志
     */
    void createApiAccessLog(ApiAccessLogCreateReqDTO createReqDTO);

    /**
     * 获得 API 访问日志分页
     *
     * @param pageReqVO 分页查询
     * @return API 访问日志分页
     */
    PageResult<ApiAccessLogDO> getApiAccessLogPage(ApiAccessLogPageReqVO pageReqVO);

    /**
     * 获得 API 访问日志列表, 用于 Excel 导出
     *
     * @param exportReqVO 查询条件
     * @return API 访问日志分页
     */
    List<ApiAccessLogDO> getApiAccessLogList(ApiAccessLogExportReqVO exportReqVO);

}
