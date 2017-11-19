-- 用户登录信息表
CREATE TABLE `customer_login`(
  `customer_id` INT UNSIGNED AUTO_INCREMENT NOT NULL COMMENT '用户id',
  `login_name` VARCHAR(20) NOT NULL COMMENT '用户登录名',
  `password` CHAR(32) NOT NULL COMMENT 'md5加密后的密码',
  `user_stats` TINYINT NOT NULL  DEFAULT 1 COMMENT '用户状态',
  `modified_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY pk_customerid(`customer_id`)
)ENGINE = Innodb COMMENT '用户登录表';

-- 用户基本信息表
CREATE TABLE `customer_inf`(
  `customer_inf_id` int UNSIGNED AUTO_INCREMENT NOT NULL COMMENT '用户信息id',
  `customer_id` INT UNSIGNED NOT NULL COMMENT '用户登录信息id',
  `customer_name` VARCHAR(20) NOT NULL COMMENT '用户真实姓名',
  `id_card_type` TINYINT NOT NULL DEFAULT 1 COMMENT '证件类型：1 身份证， 2 军官证 3 护照',
  `id_card_no` VARCHAR(20) COMMENT '证件号码',
  `mobile_phone` INT UNSIGNED COMMENT '手机号',
  `customer_email` VARCHAR(50) COMMENT '邮箱',
  `gender` CHAR(1) COMMENT '性别',
  `user_point` INT NOT NULL DEFAULT 0 COMMENT '用户积分',
  `register_time` TIMESTAMP NOT NULL COMMENT '注册时间',
  `birthday` DATETIME COMMENT '会员生日',
  `customer_level` TINYINT NOT NULL DEFAULT 1 COMMENT '会员级别：1普通会员 2青铜会员 3白银会员 4黄金会员 5钻石会员',
  `user_money` DECIMAL(8, 2) NOT NULL DEFAULT 0.00 COMMENT '用户余额',
  `modified_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY pk_customerinfoid(`customer_inf_id`)
)ENGINE = Innodb COMMENT '用户基本信息表';

-- 用户级别信息表
CREATE TABLE `customer_level_inf`(
  `customer_level` TINYINT NOT NULL AUTO_INCREMENT COMMENT '会员级别id',
  `level_name` VARCHAR(10) NOT NULL COMMENT '会员级别名字',
  `min_point` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '该级别最低积分',
  `max_point` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '该级别最高积分',
  `modified_time` TIMESTAMP NOT NULL  DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY pk_levelid(`customer_level`)
)ENGINE = Innodb COMMENT '用户级别信息表';


-- 用户地址表
CREATE TABLE `customer_addr`(
  `customer_addr_id` INT UNSIGNED NOT NULL AUTO_INCREMENT  COMMENT '用户地址信息id',
  `cutsomer_id` INT UNSIGNED NOT NULL COMMENT 'customer_login表的自增id',
  `zip` SMALLINT NOT NULL COMMENT '邮编',
  `province` SMALLINT NOT NULL COMMENT '地区表中省份的id',
  `city` SMALLINT NOT NULL COMMENT '城市表中城市id',
  `district` SMALLINT NOT NULL COMMENT '具体的区id',
  `address` VARCHAR(200) NOT NULL COMMENT '具体的门牌号',
  `is_default` TINYINT NOT NULL COMMENT '是否默认',
  `modified_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY pk_customeraddrid (`customer_addr_id`)
)ENGINE = Innodb COMMENT '用户地址表';

-- 用户积分日志表
CREATE TABLE customer_point_log(
  `point_id` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '积分日志表',
  `customer_id` INT UNSIGNED NOT NULL COMMENT '用户id',
  `source` TINYINT UNSIGNED NOT NULL COMMENT '积分来源：0 订单 1登录,2 活动',
  `refer_number` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '积分来源相关编号',
  `change_point` SMALLINT NOT NULL DEFAULT 0 COMMENT '变更积分数',
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY pk_pointid(`point_id`)
)ENGINE = Innodb COMMENT '用户积分信息表';

-- 用户余额记录表
CREATE TABLE `customer_balance_log`(
  `balance_id` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '余额日志id',
  `customer_id` INT UNSIGNED NOT NULL COMMENT '用户id',
  `source` TINYINT UNSIGNED NOT NULL COMMENT '记录来源 1 订单 2 退货单',
  `source_sn` INT UNSIGNED NOT NULL COMMENT '相关单据id',
  `amount` DECIMAL(8, 2) NOT NULL DEFAULT 0.00 COMMENT '变动金额',
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY pk_balanceid(`balance_id`)
)ENGINE = Innodb COMMENT '用户余额变动表';

-- 用户登陆日志表
CREATE TABLE `customer_login_log`(
  `login_id` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '登陆日志id',
  `customer_id` INT UNSIGNED NOT NULL COMMENT '用户id',
  `login_ip` INT UNSIGNED NOT NULL COMMENT '登陆ip',
  `login_time` TIMESTAMP NOT NULL COMMENT '用户登陆时间',
  `login_type` TINYINT NOT NULL COMMENT '登陆类型 1成功 0 未成功',
  PRIMARY KEY pk_loginid(`login_id`)
)ENGINE = Innodb COMMENT '用户登陆信息日志';

-- 用户登陆日志fenqubiao
CREATE TABLE `customer_login_log`(
  `customer_id` INT UNSIGNED NOT NULL COMMENT '用户id',
  `login_ip` INT UNSIGNED NOT NULL COMMENT '登陆ip',
  `login_time` DATETIME NOT NULL COMMENT '用户登陆时间',
  `login_type` TINYINT NOT NULL COMMENT '登陆类型 1成功 0 未成功'
)ENGINE = Innodb
  PARTITION BY RANGE (YEAR(login_time))(
    PARTITION p0 VALUES LESS THAN (2015),
    PARTITION p1 VALUES LESS THAN (2016),
    PARTITION p2 VALUES LESS THAN (2017)
  );

