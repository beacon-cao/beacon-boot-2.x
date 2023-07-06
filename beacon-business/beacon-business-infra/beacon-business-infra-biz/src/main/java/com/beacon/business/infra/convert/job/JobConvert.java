package com.beacon.business.infra.convert.job;

import com.beacon.framework.common.pojo.PageResult;
import com.beacon.business.infra.controller.admin.job.vo.job.JobCreateReqVO;
import com.beacon.business.infra.controller.admin.job.vo.job.JobExcelVO;
import com.beacon.business.infra.controller.admin.job.vo.job.JobRespVO;
import com.beacon.business.infra.controller.admin.job.vo.job.JobUpdateReqVO;
import com.beacon.business.infra.dal.dataobject.job.JobDO;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

import java.util.List;

/**
 * 定时任务 Convert
 *
 * @author Beacon
 */
@Mapper
public interface JobConvert {

    JobConvert INSTANCE = Mappers.getMapper(JobConvert.class);

    JobDO convert(JobCreateReqVO bean);

    JobDO convert(JobUpdateReqVO bean);

    JobRespVO convert(JobDO bean);

    List<JobRespVO> convertList(List<JobDO> list);

    PageResult<JobRespVO> convertPage(PageResult<JobDO> page);

    List<JobExcelVO> convertList02(List<JobDO> list);

}
