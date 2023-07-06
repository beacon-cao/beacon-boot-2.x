package com.beacon.business.system.job;

import com.beacon.framework.quartz.core.handler.JobHandler;
import com.beacon.business.system.dal.dataobject.user.AdminUserDO;
import com.beacon.business.system.dal.mysql.user.AdminUserMapper;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.util.List;

@Component
public class DemoJob implements JobHandler {

    @Resource
    private AdminUserMapper adminUserMapper;

    @Override
    public String execute(String param)  {
        List<AdminUserDO> users = adminUserMapper.selectList();
        return "用户数量：" + users.size();
    }

}
