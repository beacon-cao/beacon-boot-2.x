package com.beacon.business.infra.dal.mysql.db;

import com.beacon.framework.mybatis.core.mapper.BaseMapperX;
import com.beacon.business.infra.dal.dataobject.db.DataSourceConfigDO;
import org.apache.ibatis.annotations.Mapper;

/**
 * 数据源配置 Mapper
 *
 * @author Beacon
 */
@Mapper
public interface DataSourceConfigMapper extends BaseMapperX<DataSourceConfigDO> {
}
