import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weui/actionsheet/index.dart';
import 'package:zpub_att/com/zerogis/zpubatt/constant/FldValueConstant.dart';
import 'package:zpub_att/com/zerogis/zpubatt/resource/StringRes.dart';
import 'package:zpub_att/com/zerogis/zpubatt/resource/TextStyleRes.dart';
import 'package:zpub_bas/com/zerogis/zpubbase/constant/DigitValueConstant.dart';
import 'package:zpub_bas/com/zerogis/zpubbase/constant/MapKeyConstant.dart';
import 'package:zpub_bas/com/zerogis/zpubbase/constant/MarginPaddingHeightConstant.dart';
import 'package:zpub_bas/com/zerogis/zpubbase/constant/StringValueConstant.dart';
import 'package:zpub_bas/zpub_bas.dart';
import 'package:zpub_dbmanager/com/zerogis/zpubDbManager/bean/FldValue.dart';
import 'package:zpub_third/com/zerogis/zpubthird/util/PickerUtil.dart';

/*
 * 功能：属性相关的动态创建
 * 需要传入的键：
 * 传入的值类型：
 * 传入的值含义：
 * 是否必传 ：
 * 作者：郑朝军 on 2019/4/7 23:23
 * 邮箱：1250393285@qq.com
 * 公司：武汉智博创享科技有限公司
 */
class AttWidgetCreator
{
  /*
   * 创建公有文本<br/>
   */
  static Widget createCommonText(String text,
      {@required TextEditingController controller,
        bool enabled = true,
        int nullable,
        int disprows = 1,
        int isnum,
        String minval,
        String maxval,
        ValueChanged<String> onChanged,
        Color color})
  {
    text = text + StringValueConstant.STR_VALUE_COLON;
    return new Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Flexible(
          child: new Container(
            margin: EdgeInsets.symmetric(
                horizontal: MarginPaddingHeightConstant.APP_MARGIN_PADDING_15),
            child: Align(
                alignment: Alignment.centerRight, child: Text.rich(new TextSpan(
                text: nullable == DigitValueConstant.APP_DIGIT_VALUE_0
                    ? "*"
                    : null,
                style: TextStyleRes.text_red_color_text1_small,
                children: [
                  new TextSpan(
                      text: text, style: TextStyleRes.text_color_text1_small)
                ]))),
            height: MarginPaddingHeightConstant.APP_MARGIN_PADDING_40,
          ),
          flex: DigitValueConstant.APP_DIGIT_VALUE_2,
        ),
        new Expanded(
            flex: DigitValueConstant.APP_DIGIT_VALUE_4,
            child: new TextField(
              enabled: enabled,
              keyboardType: isnum == DigitValueConstant.APP_DIGIT_VALUE_1
                  ? TextInputType.numberWithOptions(decimal: true)
                  : null,
              controller: controller,
              maxLines: disprows,
              style: TextStyle(color: color),
              decoration: new InputDecoration(
                border: InputBorder.none,
              ),
              onChanged: (val)
              {
                if (isnum == DigitValueConstant.APP_DIGIT_VALUE_1 &&
                    !CxTextUtil.isEmpty(maxval) && !CxTextUtil.isEmpty(minval))
                {
                  if (int.parse(val) > int.parse(maxval))
                  {
                    controller.text = maxval;
                  }
                }

                if (onChanged != null)
                {
                  onChanged(val);
                }
              },
            )),
      ],
    );
  }

  /*
   * 创建公有下拉菜单
   */
  static Widget createCommonDropdownButton(String textValue,
      {dynamic value,
        int nullable,
        @required List<DropdownMenuItem> items,
        @required ValueChanged valueChangedMethod})
  {
    textValue = textValue + StringValueConstant.STR_VALUE_COLON;

    Widget textWidget = Align(
        alignment: Alignment.centerRight, child: Text.rich(new TextSpan(
        text: nullable == DigitValueConstant.APP_DIGIT_VALUE_0
            ? "*"
            : null,
        style: TextStyleRes.text_red_color_text1_small,
        children: [
          new TextSpan(
              text: textValue, style: TextStyleRes.text_color_text1_small)
        ])));

    return new Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Flexible(
          child: new Container(
            margin: EdgeInsets.symmetric(
                horizontal: MarginPaddingHeightConstant.APP_MARGIN_PADDING_15),
            child: new Center(child: textWidget),
            height: MarginPaddingHeightConstant.APP_MARGIN_PADDING_40,
          ),
          flex: DigitValueConstant.APP_DIGIT_VALUE_2,
        ),
        new Flexible(
          child: new Container(
            padding: EdgeInsets.only(
                right: MarginPaddingHeightConstant.APP_MARGIN_PADDING_5),
            child: new DropdownButtonHideUnderline(
              child: new DropdownButton(
                isExpanded: true,
                hint: new Text(
                    textValue, style: TextStyleRes.text_color_text1_small),
                value: value,
                items: items,
                onChanged: valueChangedMethod,
              ),
            ),
            height: MarginPaddingHeightConstant.APP_MARGIN_PADDING_40,
          ),
          flex: DigitValueConstant.APP_DIGIT_VALUE_4,
        ),
      ],
    );
  }

  /*
   * 创建公有拉长版本输入框
   */
  static Widget createCommonStrechTextField(String text,
      {@required TextEditingController controller, bool enabled = true, int nullable,})
  {
    return new Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Flexible(
          child: new Container(
            margin: EdgeInsets.symmetric(
                horizontal: MarginPaddingHeightConstant.APP_MARGIN_PADDING_15),
            child: Align(
                alignment: Alignment.centerRight, child: Text.rich(new TextSpan(
                text: nullable == DigitValueConstant.APP_DIGIT_VALUE_0
                    ? "*"
                    : null,
                style: TextStyleRes.text_red_color_text1_small,
                children: [
                  new TextSpan(
                      text: text, style: TextStyleRes.text_color_text1_small)
                ]))),
            height: MarginPaddingHeightConstant.APP_MARGIN_PADDING_40,
          ),
          flex: DigitValueConstant.APP_DIGIT_VALUE_2,
        ),
        new Expanded(
            flex: DigitValueConstant.APP_DIGIT_VALUE_4,
            child: new Container(
              margin: EdgeInsets.only(
                  top: MarginPaddingHeightConstant.APP_MARGIN_PADDING_15,
                  bottom: MarginPaddingHeightConstant.APP_MARGIN_PADDING_15,
                  right: MarginPaddingHeightConstant.APP_MARGIN_PADDING_15),
              child: new TextField(
                enabled: enabled,
                controller: controller,
                maxLines: DigitValueConstant.APP_DIGIT_VALUE_2,
                decoration: new InputDecoration(
                  border: OutlineInputBorder(
                    gapPadding: 1,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),
            )),
      ],
    );
  }

  /*
   * 创建公有伸展的不允许滑动的GridView组件
   */
  static Widget createCommonWrapGridView(List<Widget> children)
  {
    return new GridView.count(
        shrinkWrap: true,
        physics: new NeverScrollableScrollPhysics(),
        crossAxisCount: DigitValueConstant.APP_DIGIT_VALUE_4,
        padding: EdgeInsets.fromLTRB(
            MarginPaddingHeightConstant.APP_MARGIN_PADDING_15,
            MarginPaddingHeightConstant.APP_MARGIN_PADDING_0,
            MarginPaddingHeightConstant.APP_MARGIN_PADDING_15,
            MarginPaddingHeightConstant.APP_MARGIN_PADDING_0),
        children: children);
  }

  /*
   * 创建公用附件组件
   */
  static Widget createCommonDuplicate(List<Widget> childrens,
      {String text = StringRes.duplicate, int nullable})
  {
    text = text + StringValueConstant.STR_VALUE_COLON;
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Container(
          margin: EdgeInsets.only(
            left: MarginPaddingHeightConstant.APP_MARGIN_PADDING_15,
            top: MarginPaddingHeightConstant.APP_MARGIN_PADDING_15,
          ),
          child: Align(
              alignment: Alignment.centerLeft, child: Text.rich(new TextSpan(
              text: nullable == DigitValueConstant.APP_DIGIT_VALUE_1
                  ? "*"
                  : null,
              style: TextStyleRes.text_red_color_text1_small,
              children: [
                new TextSpan(
                    text: text, style: TextStyleRes.text_color_text1_small)
              ]))),
          height: MarginPaddingHeightConstant.APP_MARGIN_PADDING_40,
        ),
        createCommonWrapGridView(childrens)
      ],
    );
  }

  /*
   * 创建公用日期组件
   */
  static Widget createCommonDataPick(State state, String text,
      {bool enabled: true,
        @required TextEditingController controllerText,
        int disptype: 3, int nullable,
        ValueChanged<String> onChanged})
  {
    text = text + StringValueConstant.STR_VALUE_COLON;
    return new Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Flexible(
          child: new Container(
            margin: EdgeInsets.symmetric(
                horizontal: MarginPaddingHeightConstant.APP_MARGIN_PADDING_15),
            child: Align(
                alignment: Alignment.centerRight, child: Text.rich(new TextSpan(
                text: nullable == DigitValueConstant.APP_DIGIT_VALUE_0
                    ? "*"
                    : null,
                style: TextStyleRes.text_red_color_text1_small,
                children: [
                  new TextSpan(
                      text: text, style: TextStyleRes.text_color_text1_small)
                ]))),
            height: MarginPaddingHeightConstant.APP_MARGIN_PADDING_40,
          ),
          flex: DigitValueConstant.APP_DIGIT_VALUE_2,
        ),
        new Expanded(
            flex: DigitValueConstant.APP_DIGIT_VALUE_3,
            child: new TextField(
              controller: controllerText,
              enabled: false,
              decoration: new InputDecoration(
                border: InputBorder.none,
              ),
            )),
        new Flexible(
          child: new IconButton(
            onPressed: ()
            {
              if (enabled)
              {
                PickerUtil.createDateAndTimePicker(state.context,
                    disptype: disptype, valueChangedMethod: (result)
                    {
                      if (!CxTextUtil.isEmpty(result))
                      {
                        state.setState(()
                        {
                          controllerText.text = result;
                          if (onChanged != null)
                          {
                            onChanged(result);
                          }
                        });
                      }
                    });
              }
            },
            icon: new Icon(
              Icons.av_timer,
              color: Colors.blue,
            ),
          ),
          flex: DigitValueConstant.APP_DIGIT_VALUE_1,
        ),
      ],
    );
  }

  /*
   * 创建公用自定义按钮
   */
  static Widget createCommonValButton(State state, String text,
      {bool enabled: false,
        dynamic dispc,
        @required TextEditingController controllerText, int nullable,})
  {
    text = text + StringValueConstant.STR_VALUE_COLON;
    return new Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Flexible(
          child: new Container(
            margin: EdgeInsets.symmetric(
                horizontal: MarginPaddingHeightConstant.APP_MARGIN_PADDING_15),
            child: Align(
                alignment: Alignment.centerRight, child: Text.rich(new TextSpan(
                text: nullable == DigitValueConstant.APP_DIGIT_VALUE_0
                    ? "*"
                    : null,
                style: TextStyleRes.text_red_color_text1_small,
                children: [
                  new TextSpan(
                      text: text, style: TextStyleRes.text_color_text1_small)
                ]))),
            height: MarginPaddingHeightConstant.APP_MARGIN_PADDING_40,
          ),
          flex: DigitValueConstant.APP_DIGIT_VALUE_2,
        ),
        new Expanded(
            flex: DigitValueConstant.APP_DIGIT_VALUE_3,
            child: new TextField(
              controller: controllerText,
              enabled: enabled,
              decoration: new InputDecoration(
                border: InputBorder.none,
              ),
            )),
        new Flexible(
          child: new IconButton(
            onPressed: ()
            {
              FocusScope.of(state.context).requestFocus(new FocusNode());
              dispc[MapKeyConstant.MAP_KEY_VALUE_CHANGE_METHOD] =
                  (item)
              {
                state.setState(()
                {
                  Object value = item[dispc[FldValueConstant
                      .FLDVALUE_DISPC_FIEDL]];
                  if (!CxTextUtil.isEmptyObject(value))
                  {
                    controllerText.text = value;
                    dispc[MapKeyConstant.MAP_KEY_RESULT] = item;
                  }
                  else
                  {
                    controllerText.text = StringValueConstant.STR_VALUE_NULL;
                    dispc[MapKeyConstant.MAP_KEY_RESULT] = null;
                  }
                });
              };
              showDialog(
                  context: state.context,
                  builder: (widget)
                  {
                    return new SimpleDialog(
                      title: new Text(
                          dispc[MapKeyConstant.MAP_KEY_VALUE_TITLE]),
                      children: <Widget>[
                        WidgetsFactory.getInstance()
                            .get(dispc[MapKeyConstant.MAP_KEY_PLUGIN])
                            .runWidget(
                            initPara: dispc),
                      ],
                    );
                  }
              );
            },
            icon: new Icon(
              Icons.perm_contact_calendar,
              color: Colors.blue,
            ),
          ),
          flex: DigitValueConstant.APP_DIGIT_VALUE_1,
        ),
      ],
    );
  }

  /*
   * 创建公用动态参数按钮
   */
  static Widget createCommonDynamicButton(State state, String text,
      {bool enabled: false,
        dynamic dispc,
        @required TextEditingController controllerText, int nullable,})
  {
    text = text + StringValueConstant.STR_VALUE_COLON;
    return new Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Flexible(
          child: new Container(
            margin: EdgeInsets.symmetric(
                horizontal: MarginPaddingHeightConstant.APP_MARGIN_PADDING_15),
            child: Align(
                alignment: Alignment.centerRight, child: Text.rich(new TextSpan(
                text: nullable == DigitValueConstant.APP_DIGIT_VALUE_0
                    ? "*"
                    : null,
                style: TextStyleRes.text_red_color_text1_small,
                children: [
                  new TextSpan(
                      text: text, style: TextStyleRes.text_color_text1_small)
                ]))),
            height: MarginPaddingHeightConstant.APP_MARGIN_PADDING_40,
          ),
          flex: DigitValueConstant.APP_DIGIT_VALUE_2,
        ),
        new Expanded(
            flex: DigitValueConstant.APP_DIGIT_VALUE_3,
            child: new TextField(
              controller: controllerText,
              enabled: enabled,
              decoration: new InputDecoration(
                border: InputBorder.none,
              ),
            )),
        new Flexible(
          child: new IconButton(
            onPressed: ()
            {
              FocusScope.of(state.context).requestFocus(new FocusNode());
              dispc[MapKeyConstant.MAP_KEY_VALUE_CHANGE_METHOD] =
                  (item)
              {
                state.setState(()
                {
                  Object value = item[dispc[FldValueConstant
                      .FLDVALUE_DISPC_FIEDL]];
                  if (!CxTextUtil.isEmptyObject(value))
                  {
                    controllerText.text = value;
                    dispc[MapKeyConstant.MAP_KEY_RESULT] = item;
                  }
                  else
                  {
                    controllerText.text = StringValueConstant.STR_VALUE_NULL;
                    dispc[MapKeyConstant.MAP_KEY_RESULT] = null;
                  }
                });
              };
              showDialog(
                  context: state.context,
                  builder: (widget)
                  {
                    return new SimpleDialog(
                      title: new Text(
                          dispc[MapKeyConstant.MAP_KEY_VALUE_TITLE]),
                      children: <Widget>[
                        WidgetsFactory.getInstance()
                            .get(dispc[MapKeyConstant.MAP_KEY_PLUGIN])
                            .runWidget(
                            initPara: dispc),
                      ],
                    );
                  }
              );
            },
            icon: new Icon(
              Icons.perm_contact_calendar,
              color: Colors.blue,
            ),
          ),
          flex: DigitValueConstant.APP_DIGIT_VALUE_1,
        ),
      ],
    );
  }

  /*
   * 创建公用下拉(可改)按钮
   */
  static Widget createCommonDropDownModify(State state, String text,
      {@required TextEditingController controller,
        List<FldValue> options,
        bool enabled = true,
        int nullable,
        int disprows = 1,
        int isnum,
        String minval,
        String maxval,
        Color color})
  {
    text = text + StringValueConstant.STR_VALUE_COLON;
    return new Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Flexible(
          child: new Container(
            margin: EdgeInsets.symmetric(
                horizontal: MarginPaddingHeightConstant.APP_MARGIN_PADDING_15),
            child: Align(
                alignment: Alignment.centerRight, child: Text.rich(new TextSpan(
                text: nullable == DigitValueConstant.APP_DIGIT_VALUE_0
                    ? "*"
                    : null,
                style: TextStyleRes.text_red_color_text1_small,
                children: [
                  new TextSpan(
                      text: text, style: TextStyleRes.text_color_text1_small)
                ]))),
            height: MarginPaddingHeightConstant.APP_MARGIN_PADDING_40,
          ),
          flex: DigitValueConstant.APP_DIGIT_VALUE_2,
        ),
        new Expanded(
            flex: DigitValueConstant.APP_DIGIT_VALUE_3,
            child: new TextField(
              enabled: enabled,
              keyboardType: isnum == DigitValueConstant.APP_DIGIT_VALUE_1
                  ? TextInputType.number
                  : null,
              controller: controller,
              maxLines: disprows,
              style: TextStyle(color: color),
              decoration: new InputDecoration(
                border: InputBorder.none,
              ),
              onChanged: (val)
              {
                if (isnum == DigitValueConstant.APP_DIGIT_VALUE_1 &&
                    !CxTextUtil.isEmpty(maxval) && !CxTextUtil.isEmpty(minval))
                {
                  if (int.parse(val) > int.parse(maxval))
                  {
                    controller.text = maxval;
                  }
                }
              },
            )),
        new Flexible(
          child: new IconButton(
            onPressed: ()
            {
              FocusScope.of(state.context).requestFocus(new FocusNode());
              List<WeActionsheetItem> option = <WeActionsheetItem>[];
              for (int i = 0; i < options.length; i ++)
              {
                FldValue fldvalue = options[i];
                option.add(WeActionsheetItem(
                    label: fldvalue.getDispc(), value: i.toString()));
              }
              WeActionsheet.ios(state.context)(
                  title: text,
                  options: option,
                  cancelButton: '取消',
                  onChange: (String value)
                  {
                    state.setState(()
                    {
                      int position = int.parse(value);
                      controller.text = options[position].getDispc();
                    });
                  }
              );
            },
            icon: new Icon(
              Icons.perm_contact_calendar,
              color: Colors.blue,
            ),
          ),
          flex: DigitValueConstant.APP_DIGIT_VALUE_1,
        ),
      ],
    );
  }

  /*
   * 创建自动编码<br/>
   */
  static Widget createAutoCode(String text,
      {@required TextEditingController controller,
        bool enabled = true,
        int nullable,
        int disprows = 1,
        int isnum,
        String minval,
        String maxval,
        dynamic dispc,
        ValueChanged<String> onChanged,
        Color color})
  {
    dispc[MapKeyConstant.MAP_KEY_TEXT_EDITING] = controller;
    WidgetsFactory.getInstance().get(dispc[MapKeyConstant.MAP_KEY_PLUGIN]).runWidget(initPara: dispc);
    text = text + StringValueConstant.STR_VALUE_COLON;
    return new Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Flexible(
          child: new Container(
            margin: EdgeInsets.symmetric(
                horizontal: MarginPaddingHeightConstant.APP_MARGIN_PADDING_15),
            child: Align(
                alignment: Alignment.centerRight, child: Text.rich(new TextSpan(
                text: nullable == DigitValueConstant.APP_DIGIT_VALUE_0
                    ? "*"
                    : null,
                style: TextStyleRes.text_red_color_text1_small,
                children: [
                  new TextSpan(
                      text: text, style: TextStyleRes.text_color_text1_small)
                ]))),
            height: MarginPaddingHeightConstant.APP_MARGIN_PADDING_40,
          ),
          flex: DigitValueConstant.APP_DIGIT_VALUE_2,
        ),
        new Expanded(
            flex: DigitValueConstant.APP_DIGIT_VALUE_4,
            child: new TextField(
              enabled: enabled,
              keyboardType: isnum == DigitValueConstant.APP_DIGIT_VALUE_1
                  ? TextInputType.number
                  : null,
              controller: controller,
              maxLines: disprows,
              style: TextStyle(color: color),
              decoration: new InputDecoration(
                border: InputBorder.none,
              ),
              onChanged: (val)
              {
                if (isnum == DigitValueConstant.APP_DIGIT_VALUE_1 &&
                    !CxTextUtil.isEmpty(maxval) && !CxTextUtil.isEmpty(minval))
                {
                  if (int.parse(val) > int.parse(maxval))
                  {
                    controller.text = maxval;
                  }
                }

                if (onChanged != null)
                {
                  onChanged(val);
                }
              },
            )),
      ],
    );
  }
}
