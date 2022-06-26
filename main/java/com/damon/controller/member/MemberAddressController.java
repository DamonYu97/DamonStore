package com.damon.controller.member;

import com.alibaba.fastjson.JSONObject;
import com.damon.dao.entity.Member;
import com.damon.dao.entity.ReceiveAddress;
import com.damon.service.ReceiveAddressService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigInteger;
import java.nio.charset.StandardCharsets;
import java.util.List;

/**
 * @author Lilin Yu
 * @since 2019/11/19 10:21
 */
@Controller
@RequestMapping("/member/address")
public class MemberAddressController {
    private final Logger logger = Logger.getLogger(MemberAddressController.class);
    private final String MEMBER = "member";
    private final String ID = "id";
    private final String DEFAULT_ADDRESS_ID = "defaultAddressID";
    private final String DEFAULT_ID = "-1";
    private final int IS_DEFAULT = 1;
    private final int NOT_DEFAULT = 0;
    private final String RECEIVER_NAME = "receiverName";
    private final String RECEIVER_PHONE = "receiverPhone";
    private final String PROVINCE = "province";
    private final String CITY = "city";
    private final String DETAIL = "detail";
    private final String DEFAULT = "default";
    @Autowired
    private ReceiveAddressService receiveAddressService;

    /**
     * 显示当前会员所有地址
     */
    @RequestMapping(value = "/checkAddress", method = RequestMethod.POST)
    public void checkAddress(HttpServletResponse response, HttpServletRequest request) throws IOException {
        //获取当前会员ID
        HttpSession session = request.getSession();
        Member member = (Member)session.getAttribute(MEMBER);
        BigInteger memberId = member.getId();
        List<ReceiveAddress> addresses = receiveAddressService.findAllValidReceiveAddress(memberId);
        String addressString = JSONObject.toJSONString(addresses);
        logger.info("Addresses: "+ addressString);
        byte[] dataByte = addressString.getBytes(StandardCharsets.UTF_8);
        response.getOutputStream().write(dataByte);
    }

    /**
     * 设为默认地址
     */
    @RequestMapping(value = "/setAsDefault", method = RequestMethod.GET)
    public String setAsDefault(HttpServletRequest request) throws IOException {
        //获取需要设置的地址ID
        BigInteger id = new BigInteger(request.getParameter(ID));
        //更新该地址is_default字段为1
        ReceiveAddress receiveAddress = receiveAddressService.findValidReceiveAddressById(id);
        receiveAddress.setIsDefault(IS_DEFAULT);
        receiveAddressService.update(receiveAddress);
        //更新之前的默认地址为非默认
        removeDefaultAddress(request);
        return "redirect:/member/address";
    }

    /**
     * 删除地址（状态设为无效）
     */
    @RequestMapping(value = "/deleteAddress", method = RequestMethod.GET)
    public String deleteAddress(HttpServletRequest request) throws IOException {
        //获取需要设置的地址ID
        BigInteger id = new BigInteger(request.getParameter(ID));
        //更新该地址status字段为0
        ReceiveAddress receiveAddress = receiveAddressService.findValidReceiveAddressById(id);
        receiveAddress.setStatus(0);
        receiveAddressService.update(receiveAddress);
        return "redirect:/member/address";
    }

    /**
     * 添加地址
     */
    @RequestMapping(value = "/addAddress", method = RequestMethod.POST)
    public String addAddress(HttpServletRequest request) throws IOException {
        //获取当前会员ID
        HttpSession session = request.getSession();
        Member member = (Member)session.getAttribute(MEMBER);
        BigInteger memberId = member.getId();
        //获取地址信息
        String receiverName = request.getParameter(RECEIVER_NAME);
        String receiverPhone = request.getParameter(RECEIVER_PHONE);
        String province = request.getParameter(PROVINCE);
        String city = request.getParameter(CITY);
        String detail = request.getParameter(DETAIL);
        String isDefaultString = request.getParameter(DEFAULT);
        int isDefault = 0;
        if (("" + IS_DEFAULT).equals(isDefaultString)) {
            isDefault = IS_DEFAULT;
            //更新之前的默认地址为非默认
            removeDefaultAddress(request);
        }
        logger.info("add address: " + isDefault);
        //添加地址
        ReceiveAddress receiveAddress = new ReceiveAddress();
        receiveAddress.setMemberId(memberId);
        receiveAddress.setReceiverName(receiverName);
        receiveAddress.setReceiverPhone(receiverPhone);
        receiveAddress.setProvince(province);
        receiveAddress.setCity(city);
        receiveAddress.setDetail(detail);
        receiveAddress.setIsDefault(isDefault);
        receiveAddressService.create(receiveAddress);
        return "redirect:/member/address";
    }

    private void removeDefaultAddress(HttpServletRequest request) {
        //更新之前的默认地址为非默认
        //1.获取前台获取的之前默认地址的ID 如果是-1，则无默认地址
        String defaultIdString = request.getParameter(DEFAULT_ADDRESS_ID);
        logger.info("Default address id: " + defaultIdString);
        if (!DEFAULT_ID.equals(defaultIdString)) {
            BigInteger defaultId = new BigInteger(defaultIdString);
            //2.更新之前默认地址is_default字段为0
            ReceiveAddress defaultReceiveAddress = receiveAddressService.findValidReceiveAddressById(defaultId);
            defaultReceiveAddress.setIsDefault(NOT_DEFAULT);
            receiveAddressService.update(defaultReceiveAddress);
        }
    }

    /**
     * 更新地址
     */
    @RequestMapping(value = "/updateAddress", method = RequestMethod.POST)
    public String updateAddress(HttpServletRequest request) throws IOException {
        //获取地址信息
        BigInteger id = new BigInteger(request.getParameter(ID));
        String receiverName = request.getParameter(RECEIVER_NAME);
        String receiverPhone = request.getParameter(RECEIVER_PHONE);
        String province = request.getParameter(PROVINCE);
        String city = request.getParameter(CITY);
        String detail = request.getParameter(DETAIL);
        //更新地址
        ReceiveAddress receiveAddress = receiveAddressService.findValidReceiveAddressById(id);
        receiveAddress.setReceiverName(receiverName);
        receiveAddress.setReceiverPhone(receiverPhone);
        receiveAddress.setProvince(province);
        receiveAddress.setCity(city);
        receiveAddress.setDetail(detail);
        receiveAddressService.update(receiveAddress);
        return "redirect:/member/address";
    }
}
