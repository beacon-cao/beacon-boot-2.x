package com.beacon.business.system.service.logger;

import com.beacon.framework.common.pojo.PageResult;
import com.beacon.business.system.api.logger.dto.LoginLogCreateReqDTO;
import com.beacon.business.system.controller.admin.logger.vo.loginlog.LoginLogExportReqVO;
import com.beacon.business.system.controller.admin.logger.vo.loginlog.LoginLogPageReqVO;
import com.beacon.business.system.convert.logger.LoginLogConvert;
import com.beacon.business.system.dal.dataobject.logger.LoginLogDO;
import com.beacon.business.system.dal.mysql.logger.LoginLogMapper;
import org.springframework.stereotype.Service;
import org.springframework.validation.annotation.Validated;

import javax.annotation.Resource;
import java.util.List;

/**
 * 登录日志 Service 实现
 */
@Service
@Validated
public class LoginLogServiceImpl implements LoginLogService {

    @Resource
    private LoginLogMapper loginLogMapper;

    @Override
    public PageResult<LoginLogDO> getLoginLogPage(LoginLogPageReqVO reqVO) {
        return loginLogMapper.selectPage(reqVO);
    }

    @Override
    public List<LoginLogDO> getLoginLogList(LoginLogExportReqVO reqVO) {
        return loginLogMapper.selectList(reqVO);
    }

    @Override
    public void createLoginLog(LoginLogCreateReqDTO reqDTO) {
        LoginLogDO loginLog = LoginLogConvert.INSTANCE.convert(reqDTO);
        loginLogMapper.insert(loginLog);
    }

}
