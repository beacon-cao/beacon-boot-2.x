package com.beacon.business.infra.convert.logger;

import com.beacon.framework.common.pojo.PageResult;
import com.beacon.business.infra.api.logger.dto.ApiAccessLogCreateReqDTO;
import com.beacon.business.infra.controller.admin.logger.vo.apiaccesslog.ApiAccessLogExcelVO;
import com.beacon.business.infra.controller.admin.logger.vo.apiaccesslog.ApiAccessLogRespVO;
import com.beacon.business.infra.dal.dataobject.logger.ApiAccessLogDO;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

import java.util.List;

/**
 * API 访问日志 Convert
 *
 * @author Beacon
 */
@Mapper
public interface ApiAccessLogConvert {

    ApiAccessLogConvert INSTANCE = Mappers.getMapper(ApiAccessLogConvert.class);

    ApiAccessLogRespVO convert(ApiAccessLogDO bean);

    List<ApiAccessLogRespVO> convertList(List<ApiAccessLogDO> list);

    PageResult<ApiAccessLogRespVO> convertPage(PageResult<ApiAccessLogDO> page);

    List<ApiAccessLogExcelVO> convertList02(List<ApiAccessLogDO> list);

    ApiAccessLogDO convert(ApiAccessLogCreateReqDTO bean);

}
