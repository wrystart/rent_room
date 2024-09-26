export type ICallBack = (arg?: unknown) => unknown;

export type ICallBacks = ICallBack[]

export interface IEvents {
  [key: string]: ICallBacks
}

function createEmitter() {
  /* 功能：存储自定义事件的容器
   * 容器结构:
   *  {
   *     事件名称: [回调函数1,回调函数2,...]
   *  }
   *
   * */
  const events: IEvents = {};

  return {
    // 绑定自定义事件
    // eventName 自定义事件名称 callback 自定义事件回调函数
    on(eventName: string, callback: ICallBack) {
      if (events[eventName]) {
        events[eventName].push(callback) //第一次以后添加
      } else {
        events[eventName] = [callback]; // 第一次添加
      }
    },
    // 解绑自定义事件
    off(eventName: string, callback?: ICallBack) {
      /*
       * off('eventName') 解绑该事件(eventName)的所有回调函数
       * off('eventName','cb') 解绑该事件(eventName)的一个回调函数
       * */

      const callbacks = events[eventName]
      if (!callback) {
        return
      }
      if (callback) {
        // 解绑一个
        // 比较函数是否相同，比较的是地址值
        events[eventName] = callbacks.filter(cb => cb !== callback)
      } else {
        // 解绑所有
        delete events[eventName]
      }
    },
    // 触发自定义事件
    // eventName 自定义事件名称 arg 自定义事件回调函数的参数
    emit(eventName: string, arg?: unknown) {
      const callbacks = events[eventName];
      if (!callbacks) {
        return
      }
      // 遍历所有函数，一一执行
      callbacks.forEach(cb => cb(arg))
    }
  }
}


const globalEmitter = createEmitter()

export default globalEmitter;