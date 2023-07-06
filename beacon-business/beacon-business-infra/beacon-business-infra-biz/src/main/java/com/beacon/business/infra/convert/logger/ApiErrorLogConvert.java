package com.beacon.business.infra.convert.logger;

import com.beacon.framework.common.pojo.PageResult;
import com.beacon.business.infra.api.logger.dto.ApiErrorLogCreateReqDTO;
import com.beacon.business.infra.controller.admin.logger.vo.apierrorlog.ApiErrorLogExcelVO;
import com.beacon.business.infra.controller.admin.logger.vo.apierrorlog.ApiErrorLogRespVO;
import com.beacon.business.infra.dal.dataobject.logger.ApiErrorLogDO;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

import java.util.List;

/**
 * API 错误日志 Convert
 *
 * @author Beacon
 */
@Mapper
public interface ApiErrorLogConvert {

    ApiErrorLogConvert INSTANCE = Mappers.getMapper(ApiErrorLogConvert.class);

    ApiErrorLogRespVO convert(ApiErrorLogDO bean);

    PageResult<ApiErrorLogRespVO> convertPage(PageResult<ApiErrorLogDO> page);

    List<ApiErrorLogExcelVO> convertList02(List<ApiErrorLogDO> list);

    ApiErrorLogDO convert(ApiErrorLogCreateReqDTO bean);

}
