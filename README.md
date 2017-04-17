# objective-c
  关于objective-c的练习

* ## MyDush
  基于UIBezierPath和CAShapeLayer的小练习

* ## MHClock
  A Simple Clock      
  一个简单的小时钟   

  ### 使用方法    
  引入MHClockView.h类   
  初始化并加入视图中即可使用    

  ### 内置属性
      /**
       *  表盘颜色 默认白色
       */
      @property (nonatomic,retain) UIColor *clockFaceColor;
      /**
       *  表盘边框颜色 默认黑色
       */
      @property (nonatomic,retain) UIColor *clockFaceEdgeColr;
      /**
       *  数字颜色 默认黑色
       */
      @property (nonatomic,retain) UIColor *clockNumberColor;
      /**
       *  时针颜色 默认黑色
       */
      @property (nonatomic,retain) UIColor *hourHandColor;
      /**
       *  分针颜色 默认黑色
       */
      @property (nonatomic,retain) UIColor *minuteHandColor;
      /**
       *  秒针颜色 默认红色
       */
      @property (nonatomic,retain) UIColor *secondHandColor;


* ## CollectionViewPractise
  WaterFullView By UICollectionView
  通过自定义了UICollectionViewCell和UICollectionViewLayout实现了简单的瀑布流视图
