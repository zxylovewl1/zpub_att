import 'package:flutter/widgets.dart';
import 'package:zpub_bas/zpub_bas.dart';
import 'package:zpub_bas/com/zerogis/zpubbase/constant/MapKeyConstant.dart';
import 'package:zpub_dbmanager/com/zerogis/zpubDbManager/constant/FldConstant.dart';

import 'AttWidget.dart';

/*
 * 类描述：首页组件提供的Service
 * 作者：郑朝军 on 2019/6/6
 * 邮箱：1250393285@qq.com
 * 公司：武汉智博创享科技有限公司
 * 修改人：郑朝军 on 2019/6/6
 * 修改备注：
 */
class AttWidgetService extends InterfaceBaseImpl
{
  @override
  Widget runWidget({dynamic initPara})
  {
    if (initPara == null)
    {
      return SysWidgetCreator.createCommonNoData();
    }
    else
    {
      return new AttWidget(
        initPara[FldConstant.FLD_MAJOR],
        initPara[FldConstant.FLD_MINOR],
        mId: initPara[FldConstant.FLD_ID],
        key: initPara[MapKeyConstant.MAP_KEY_GLOBAL_KEY],
      );
    }
  }
}
