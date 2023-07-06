package com.beacon.business.system.dal.mysql.notice;

import com.beacon.framework.common.pojo.PageResult;
import com.beacon.framework.mybatis.core.mapper.BaseMapperX;
import com.beacon.framework.mybatis.core.query.LambdaQueryWrapperX;
import com.beacon.business.system.controller.admin.notice.vo.NoticePageReqVO;
import com.beacon.business.system.dal.dataobject.notice.NoticeDO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface NoticeMapper extends BaseMapperX<NoticeDO> {

    default PageResult<NoticeDO> selectPage(NoticePageReqVO reqVO) {
        return selectPage(reqVO, new LambdaQueryWrapperX<NoticeDO>()
                .likeIfPresent(NoticeDO::getTitle, reqVO.getTitle())
                .eqIfPresent(NoticeDO::getStatus, reqVO.getStatus())
                .orderByDesc(NoticeDO::getId));
    }

}
