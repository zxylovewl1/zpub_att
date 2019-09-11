import 'package:flutter/material.dart';
import 'package:zpub_att/com/zerogis/zpubatt/widget/AttItemWidget.dart';
import 'package:zpub_dbmanager/com/zerogis/zpubDbManager/bean/Fld.dart';
import 'package:zpub_bas/com/zerogis/zpubbase/constant/DigitValueConstant.dart';
import 'package:zpub_dbmanager/com/zerogis/zpubDbManager/manager/EntityManager.dart';
import 'package:zpub_dbmanager/com/zerogis/zpubDbManager/manager/EntityManagerConstant.dart';
import 'package:zpub_dbmanager/com/zerogis/zpubDbManager/manager/FldManager.dart';
import 'package:zpub_bas/zpub_bas.dart';
import 'package:zpub_bas/com/zerogis/zpubbase/resource/StringRes.dart';
import 'package:zpub_att/zpub_att.dart';
import 'package:zpub_plugin/com/zerogis/zpubPlugin/widget/WidgetStatefulBase.dart';
import 'package:zpub_dbmanager/com/zerogis/zpubDbManager/manager/FldManagerConstant.dart';
import 'package:zpub_svr/zpub_svr.dart';

/*
 * 根据主子类型生成属性组件:不传ID则不请求网络生成属性 <br/>
 * 需要传入的键：<br/>
 * 传入的值类型： <br/>
 * 传入的值含义：<br/>
 * 是否必传 ：
 */
class AttWidget extends WidgetStatefulBase
{
  /*
   * 属性主类型
   */
  int mMajor;

  /*
   * 属性子类型
   */
  int mMinor;

  /*
   * 属性表中对应的ID值
   */
  int mId;

  /*
   * 当前属性的值
   */
  Map<String, dynamic> mAttVals;

  /*
   * 查询属性数据回调方法
   */
  ValueChanged<dynamic> mValueChangedMethod;

  /*
   * 属性是否可编辑
   */
  bool mEditable;

  AttWidget(this.mMajor, this.mMinor,
      {Key key, @required this.mId = -1, this.mAttVals, this.mValueChangedMethod, this.mEditable: true, plugin})
      : super(key: key, plugin: plugin);

  State<StatefulWidget> createState()
  {
    return new AttWidgetState();
  }

  static String toStrings()
  {
    return "AttWidget";
  }
}

/*
 * 属性组件功能 <br/>
 */
class AttWidgetState<T extends AttWidget> extends WidgetBaseState<T>
{
  /*
   * 当前属性的表名
   */
  String mTabName;

  /*
   * 当前属性的列
   */
  List<Fld> mFldList;

  /*
   * 当前属性所有的组件
   */
  Map<GlobalKey<State<StatefulWidget>>, Widget> mChildrenAttItem = {};

  /*
   * 当前属性的值
   */
  Map<String, dynamic> mAttWidgetValues = {};

  void initState()
  {
    super.initState();
    query();
    if (!CxTextUtil.isEmptyMap(widget.mAttVals))
    {
      mAttWidgetValues = widget.mAttVals;
    }
  }

  Widget build(BuildContext context)
  {
    Widget widget = new ListView(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: createAttList(),
    );
    return widget;
  }

  /*
   * 查询属性
   */
  void query()
  {
    if (widget.mId != DigitValueConstant.APP_DIGIT_VALUE__1)
    {
      CommonService.queryAttJo(widget.mMajor, widget.mMinor, widget.mId, this);
    }
  }

  /*
   * 初始化数据 
   */
  void initData()
  {
    super.initData();
    EntityManagerConstant entityManagerConstant = EntityManager.getInstance();
    FldManagerConstant fldManagerConstant = FldManager.getInstance();
    mTabName =
        entityManagerConstant.queryEntityTabbatt(widget.mMajor, widget.mMinor);
    mFldList = fldManagerConstant.queryFldListSortDisporder(mTabName);
  }

  /*
   * 创建属性集合
   */
  List<Widget> createAttList()
  {
    if (widget.mId == DigitValueConstant.APP_DIGIT_VALUE__1)
    {
      return createAttItemList();
    }
    else if (CxTextUtil.isEmptyMap(mAttWidgetValues))
    {
      return SysWidgetCreator.createCommonNoDataList(
          text: StringRes.progressbar_text);
    }
    else
    {
      return createAttItemList();
    }
  }

  /*
   * 创建属性集合的条目
   */
  List<Widget> createAttItemList()
  {
    mChildrenAttItem.clear();
    for (int i = 0; i < mFldList.length; i++)
    {
      Fld fld = mFldList[i];
      editableFld(fld);
      if (filterFldItem(fld))
      {
        GlobalKey key = new GlobalKey<AttItemWidgetState>();
        initFlds(key, fld);
        mChildrenAttItem[new GlobalKey<AttItemWidgetState>()] =
            SysWidgetCreator.createCommonDevider();
      }
    }
    return mChildrenAttItem.values.toList();
  }

  /*
   * 是否过滤fld的条目
   * @param fld listview中一个条目生成的item值
   * return [false=过滤]
   */
  bool filterFldItem(Fld fld)
  {
    if (fld.getDisporder() > DigitValueConstant.APP_DIGIT_VALUE_0)
    {
      return true;
    }
    else
    {
      return false;
    }
  }

  /*
   * 初始化数据输入值
   * @method
   * @param   {Fld}       flds              所有字段信息
   */
  void initFlds(GlobalKey key, Fld fld)
  {
    mChildrenAttItem[key] = new AttItemWidget(fld, mValue: mAttWidgetValues[fld.getColname()], key: key);
  }

  /*
   * 编辑Fld字段的Editable值
   * @method
   * @param   {Fld}       flds              所有字段信息
   */
  void editableFld(Fld fld)
  {
    if (!widget.mEditable)
    {
      fld.setEditable(0);
    }
  }

  /*
   * 网络层接口回调
   */
  void onNetWorkSucceed(String method, Object values)
  {
    if (method == "queryAttJo")
    {
      dealQueryAttJo(values);
    }
  }

  /*
   * 处理网络层查询属性
   */
  void dealQueryAttJo(Object values)
  {
    if (values is Map)
    {
      setState(()
      {
        mAttWidgetValues = values;
      });
      if (widget.mValueChangedMethod != null)
      {
        widget.mValueChangedMethod(values);
      }
    }
  }

  /*
   * 查询属性的键值
   * @retrun result = [{fld: Instance of 'Fld', value: 测试},{fld: Instance of 'Fld', value: 测试},]
   */
  List<Map> queryAttKeyValue()
  {
    List<Map> result = <Map>[];
    mChildrenAttItem.forEach((key, widgetChild)
    {
      if (widgetChild is AttItemWidget)
      {
        if (key.currentState is AttItemWidgetState)
        {
          AttItemWidgetState state = key.currentState;
          Map map = state.queryItemKeyValue();
          result.add(map);
        }
      }
    });
    return result;
  }
}
