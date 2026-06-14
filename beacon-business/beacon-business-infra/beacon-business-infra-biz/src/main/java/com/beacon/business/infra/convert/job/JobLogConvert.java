package com.beacon.business.infra.convert.job;

import com.beacon.framework.common.pojo.PageResult;
import com.beacon.business.infra.controller.admin.job.vo.log.JobLogExcelVO;
import com.beacon.business.infra.controller.admin.job.vo.log.JobLogRespVO;
import com.beacon.business.infra.dal.dataobject.job.JobLogDO;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

import java.util.List;

/**
 * 定时任务日志 Convert
 *
 * @author beacon
 */
@Mapper
public interface JobLogConvert {

    JobLogConvert INSTANCE = Mappers.getMapper(JobLogConvert.class);

    JobLogRespVO convert(JobLogDO bean);

    List<JobLogRespVO> convertList(List<JobLogDO> list);

    PageResult<JobLogRespVO> convertPage(PageResult<JobLogDO> page);

    List<JobLogExcelVO> convertList02(List<JobLogDO> list);

}
