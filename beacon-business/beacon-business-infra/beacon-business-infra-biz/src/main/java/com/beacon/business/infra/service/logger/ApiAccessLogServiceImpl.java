package com.beacon.business.infra.service.logger;

import com.beacon.framework.common.pojo.PageResult;
import com.beacon.business.infra.api.logger.dto.ApiAccessLogCreateReqDTO;
import com.beacon.business.infra.controller.admin.logger.vo.apiaccesslog.ApiAccessLogExportReqVO;
import com.beacon.business.infra.controller.admin.logger.vo.apiaccesslog.ApiAccessLogPageReqVO;
import com.beacon.business.infra.convert.logger.ApiAccessLogConvert;
import com.beacon.business.infra.dal.dataobject.logger.ApiAccessLogDO;
import com.beacon.business.infra.dal.mysql.logger.ApiAccessLogMapper;
import org.springframework.stereotype.Service;
import org.springframework.validation.annotation.Validated;

import javax.annotation.Resource;
import java.util.List;

/**
 * API 访问日志 Service 实现类
 *
 * @author Beacon
 */
@Service
@Validated
public class ApiAccessLogServiceImpl implements ApiAccessLogService {

    @Resource
    private ApiAccessLogMapper apiAccessLogMapper;

    @Override
    public void createApiAccessLog(ApiAccessLogCreateReqDTO createDTO) {
        ApiAccessLogDO apiAccessLog = ApiAccessLogConvert.INSTANCE.convert(createDTO);
        apiAccessLogMapper.insert(apiAccessLog);
    }

    @Override
    public PageResult<ApiAccessLogDO> getApiAccessLogPage(ApiAccessLogPageReqVO pageReqVO) {
        return apiAccessLogMapper.selectPage(pageReqVO);
    }

    @Override
    public List<ApiAccessLogDO> getApiAccessLogList(ApiAccessLogExportReqVO exportReqVO) {
        return apiAccessLogMapper.selectList(exportReqVO);
    }

}
