import 'package:flutter/material.dart';
import 'package:zpub_att/com/zerogis/zpubatt/constant/FldValueConstant.dart';
import 'package:zpub_att/com/zerogis/zpubatt/core/AttWidgetCreator.dart';
import 'package:zpub_dbmanager/com/zerogis/zpubDbManager/bean/Fld.dart';
import 'package:zpub_dbmanager/com/zerogis/zpubDbManager/bean/FldValue.dart';
import 'package:zpub_bas/com/zerogis/zpubbase/constant/DigitValueConstant.dart';
import 'package:zpub_bas/com/zerogis/zpubbase/constant/StringValueConstant.dart';
import 'package:zpub_dbmanager/com/zerogis/zpubDbManager/manager/FldValuesManager.dart';
import 'package:zpub_dbmanager/com/zerogis/zpubDbManager/manager/FldValuesManagerConstant.dart';
import 'package:zpub_bas/zpub_bas.dart';
import 'package:zpub_bas/com/zerogis/zpubbase/constant/MapKeyConstant.dart';

/*
 * 属性条目生成组件(条目兼容文本，日期，日期+时间，spinner，富文本） <br/>
 * 需要传入的键：<br/>
 * 传入的值类型： <br/>
 * 传入的值含义：<br/>
 * 是否必传 ：
 */
class AttItemWidget extends StatefulWidget
{
  /*
   * 生成条目的依据
   */
  Fld mFld;

  /*
   * 属性中的值
   */
  dynamic mValue;

  /*
   * 值改变回调
   */
  ValueChanged<String> mOnChanged;

  AttItemWidget(this.mFld, {this.mValue, Key key, this.mOnChanged}) : super(key: key);

  State<StatefulWidget> createState()
  {
    return new AttItemWidgetState();
  }

  static String toStrings()
  {
    return "AttItemWidget";
  }
}

/*
 * 组件功能 <br/>
 */
class AttItemWidgetState extends State<AttItemWidget>
{
  /*
   * 条目左边的文本
   */
  String mSText;

  /*
   * 输入框
   */
  TextEditingController mController;

  /*
   * 下拉菜单值
   */
  List<DropdownMenuItem> mDropdownMenuList;

  /*
   * 下拉菜单默认选择的值
   */
  dynamic mDropdownSelectMenuItem;

  /*
   * 动态参数按钮fldvalue表despc的值
   */
  dynamic mDynamicBtnDispc;

  void initState()
  {
    super.initState();
    mSText = widget.mFld.getNamec();
    if (widget.mFld.disptype == DigitValueConstant.APP_DIGIT_VALUE_1 ||
        widget.mFld.disptype == DigitValueConstant.APP_DIGIT_VALUE_3 ||
        widget.mFld.disptype == DigitValueConstant.APP_DIGIT_VALUE_4 ||
        widget.mFld.disptype == DigitValueConstant.APP_DIGIT_VALUE_5 ||
        widget.mFld.disptype == DigitValueConstant.APP_DIGIT_VALUE_10 ||
        widget.mFld.disptype == DigitValueConstant.APP_DIGIT_VALUE_12)
    {
      // 文本
      String defval = widget.mFld.getDefval();
      mController = new TextEditingController();
      if (!CxTextUtil.isEmptyObject(widget.mValue))
      {
        mController.text = widget.mValue.toString();
      }
      else if (!CxTextUtil.isEmptyObject(defval) && !defval.contains(StringValueConstant.STR_VALUE_DOOLAR))
      {
        mController.text = widget.mFld.getDefval();
      }
    }
    else if (widget.mFld.disptype == DigitValueConstant.APP_DIGIT_VALUE_2)
    {
      // 下拉框
      initDropdownMenuList();
    }
    else if (widget.mFld.disptype == DigitValueConstant.APP_DIGIT_VALUE_6)
    {
      // 下拉(可改)
      mController = new TextEditingController();
      mController.text = widget.mValue ?? "";
      mDropdownSelectMenuItem = queryFldValueGetSpinnerDataSort();
    }
    else if (widget.mFld.disptype == DigitValueConstant.APP_DIGIT_VALUE_8)
    {
      // 下拉框
      mDropdownMenuList = new List();
      mDropdownSelectMenuItem = widget.mValue ?? mSText;
      mDropdownMenuList.add(DropdownMenuItem(
          child: Text(widget.mValue ?? mSText),
          value: widget.mValue ?? mSText));
    }
    else if (widget.mFld.disptype == DigitValueConstant.APP_DIGIT_VALUE_9 ||
        widget.mFld.disptype == DigitValueConstant.APP_DIGIT_VALUE_11 ||
        widget.mFld.disptype == DigitValueConstant.APP_DIGIT_VALUE_7)
    {
      // 下拉框
      mController = new TextEditingController();
      initPluginParam();
    }
  }

  Widget build(BuildContext context)
  {
    Widget body;
    if (widget.mFld.disptype == DigitValueConstant.APP_DIGIT_VALUE_1)
    {
      // 文本
      body = createText();
    }
    else if (widget.mFld.disptype == DigitValueConstant.APP_DIGIT_VALUE_2)
    {
      // 下拉框
      body = createDropdownButton();
    }
    else if (widget.mFld.disptype == DigitValueConstant.APP_DIGIT_VALUE_3)
    {
      // 日期
      body = AttWidgetCreator.createCommonDataPick(this, mSText,
          enabled: widget.mFld.getEditable() ==
              DigitValueConstant.APP_DIGIT_VALUE_1 ? true : false,
          controllerText: mController, nullable: widget.mFld.getNullable(), onChanged: widget.mOnChanged);
    }
    else if (widget.mFld.disptype == DigitValueConstant.APP_DIGIT_VALUE_4)
    {
      // 富文本
      body = AttWidgetCreator.createCommonStrechTextField(
          mSText, nullable: widget.mFld.getNullable());
    }
    else if (widget.mFld.disptype == DigitValueConstant.APP_DIGIT_VALUE_5)
    {
      // 日期+时间
      body = AttWidgetCreator.createCommonDataPick(this, mSText,
          controllerText: mController,
          enabled: widget.mFld.getEditable() ==
              DigitValueConstant.APP_DIGIT_VALUE_1 ? true : false,
          disptype: widget.mFld.disptype,
          nullable: widget.mFld.getNullable(),
          onChanged: widget.mOnChanged);
    }
    else if (widget.mFld.disptype == DigitValueConstant.APP_DIGIT_VALUE_6)
    {
      // 下拉(可改)
      body = AttWidgetCreator.createCommonDropDownModify(this, mSText,
        controller: mController,
        options: mDropdownSelectMenuItem,
        enabled: widget.mFld.getEditable() ==
            DigitValueConstant.APP_DIGIT_VALUE_1 ? true : false,
        isnum: widget.mFld.getIsnum(),
        nullable: widget.mFld.getNullable(),
        disprows: widget.mFld.getDisprows(),
        maxval: widget.mFld.getMaxval(),
        minval: widget.mFld.getMinval(),
      );
    }
    else if (widget.mFld.disptype == DigitValueConstant.APP_DIGIT_VALUE_7)
    {
      // 自定义按钮
      body = AttWidgetCreator.createCommonValButton(this,
          mSText, controllerText: mController,
          dispc: mDynamicBtnDispc,
          nullable: widget.mFld.getNullable());
    }
    else if (widget.mFld.disptype == DigitValueConstant.APP_DIGIT_VALUE_8)
    {
      // 选择操作人的部门或职位
      body = createDropdownButton();
    }
    else if (widget.mFld.disptype == DigitValueConstant.APP_DIGIT_VALUE_9)
    {
      // 动态选择
      body = AttWidgetCreator.createCommonDynamicButton(
          this, mSText, controllerText: mController,
          nullable: widget.mFld.getNullable(), dispc: mDynamicBtnDispc);
    }
    else if (widget.mFld.disptype == DigitValueConstant.APP_DIGIT_VALUE_10)
    {
      // 高亮文本
      body = createText(color: Colors.red);
    }
    else if (widget.mFld.disptype == DigitValueConstant.APP_DIGIT_VALUE_11)
    {
      // 自动编码
      body = AttWidgetCreator.createAutoCode(mSText,
          controller: mController,
          enabled: widget.mFld.getEditable() ==
              DigitValueConstant.APP_DIGIT_VALUE_1 ? true : false,
          isnum: widget.mFld.getIsnum(),
          nullable: widget.mFld.getNullable(),
          disprows: widget.mFld.getDisprows(),
          onChanged: widget.mOnChanged,
          dispc: mDynamicBtnDispc);
    }
    else if (widget.mFld.disptype == DigitValueConstant.APP_DIGIT_VALUE_12)
    {
      // 时间(没有日期)
      body = AttWidgetCreator.createCommonDataPick(this, mSText,
          controllerText: mController,
          disptype: widget.mFld.disptype,
          nullable: widget.mFld.getNullable());
    }
    else
    {
      int disptype = widget.mFld.disptype;
      body = new Text("暂不支持此功能:disptype为{$disptype}");
    }
    return body;
  }

  /*
   * 初始化下拉菜单集合
   */
  void initDropdownMenuList()
  {
    mDropdownMenuList = new List();
    List<FldValue> result = queryFldValueGetSpinnerDataSort();
    result.forEach((fldvalue)
    {
      if (widget.mValue == null)
      {
        mDropdownSelectMenuItem = result.first;
      }
      else if (widget.mValue == int.parse(fldvalue.getDbvalue()))
      {
        mDropdownSelectMenuItem = fldvalue;
      }
      mDropdownMenuList.add(
          DropdownMenuItem(child: Text(fldvalue.getDispc()), value: fldvalue));
    });
  }

  /*
   * 根据：表名和列名(tabName，colname) 查询到fldvalue集合(根据DbValue进行排好序的fldvalue集合)
   */
  List<FldValue> queryFldValueGetSpinnerDataSort()
  {
    FldValuesManagerConstant fldValuesManagerConstant = FldValuesManager
        .getInstance();
    return fldValuesManagerConstant.queryFldValueGetSpinnerDataSort(
        widget.mFld.getTabname(), widget.mFld.getColname());
  }

  /*
   * 初始化下拉菜单集合
   */
  void initPluginParam()
  {
    FldValuesManagerConstant fldValuesManagerConstant = FldValuesManager.getInstance();
    mDynamicBtnDispc = fldValuesManagerConstant.queryFldValueDispc(
        widget.mFld.getTabname(), widget.mFld.getColname(),
        FldValueConstant.FLDVALUE_MS);
  }

  /*
   * 创建公有文本
   */
  Widget createText({Color color})
  {
    return AttWidgetCreator.createCommonText(mSText,
      controller: mController,
      color: color,
      enabled: widget.mFld.getEditable() ==
          DigitValueConstant.APP_DIGIT_VALUE_1 ? true : false,
      isnum: widget.mFld.getIsnum(),
      nullable: widget.mFld.getNullable(),
      disprows: widget.mFld.getDisprows(),
      maxval: widget.mFld.getMaxval(),
      minval: widget.mFld.getMinval(),
      onChanged: widget.mOnChanged,
    );
  }

  /*
   * 创建公有下拉菜单
   */
  Widget createDropdownButton()
  {
    return AttWidgetCreator.createCommonDropdownButton(mSText,
        value: mDropdownSelectMenuItem,
        items: mDropdownMenuList, valueChangedMethod: (fldvalue)
        {
          setState(()
          {
            mDropdownSelectMenuItem = fldvalue;
          });
        },
        nullable: widget.mFld.getNullable());
  }

  /*
   * 查询当前条目的值
   * @retrun result = {fld: Instance of 'Fld', value: 测试}
   */
  Map queryItemKeyValue()
  {
    Map<String, dynamic> map = {};
    map[MapKeyConstant.MAP_KEY_FLD] = widget.mFld;
    if (widget.mFld.disptype == DigitValueConstant.APP_DIGIT_VALUE_1 ||
        widget.mFld.disptype == DigitValueConstant.APP_DIGIT_VALUE_5 ||
        widget.mFld.disptype == DigitValueConstant.APP_DIGIT_VALUE_4 ||
        widget.mFld.disptype == DigitValueConstant.APP_DIGIT_VALUE_6 ||
        widget.mFld.disptype == DigitValueConstant.APP_DIGIT_VALUE_10 ||
        widget.mFld.disptype == DigitValueConstant.APP_DIGIT_VALUE_12 ||
        widget.mFld.disptype == DigitValueConstant.APP_DIGIT_VALUE_3)
    {
      // 文本
      map[MapKeyConstant.MAP_KEY_VALUE] = mController.text;
    }
    else if (widget.mFld.disptype == DigitValueConstant.APP_DIGIT_VALUE_2)
    {
      // 下拉框
      map[MapKeyConstant.MAP_KEY_VALUE] = mDropdownSelectMenuItem;
    }
    else if (widget.mFld.disptype == DigitValueConstant.APP_DIGIT_VALUE_8)
    {
      // 选择操作人的部门或职位
      map[MapKeyConstant.MAP_KEY_VALUE] = widget.mValue;
    }
    else if (widget.mFld.disptype == DigitValueConstant.APP_DIGIT_VALUE_9 ||
        widget.mFld.disptype == DigitValueConstant.APP_DIGIT_VALUE_11 ||
        widget.mFld.disptype == DigitValueConstant.APP_DIGIT_VALUE_7)
    {
      // 动态选择
      map[MapKeyConstant.MAP_KEY_VALUE] = mController.text;
      map[MapKeyConstant.MAP_KEY_RESULT] = mDynamicBtnDispc;
    }
    return map;
  }
}
