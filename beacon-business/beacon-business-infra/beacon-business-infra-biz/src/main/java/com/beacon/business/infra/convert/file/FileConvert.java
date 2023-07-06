package com.beacon.business.infra.convert.file;

import com.beacon.framework.common.pojo.PageResult;
import com.beacon.business.infra.controller.admin.file.vo.file.FileRespVO;
import com.beacon.business.infra.dal.dataobject.file.FileDO;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

@Mapper
public interface FileConvert {

    FileConvert INSTANCE = Mappers.getMapper(FileConvert.class);

    FileRespVO convert(FileDO bean);

    PageResult<FileRespVO> convertPage(PageResult<FileDO> page);

}
