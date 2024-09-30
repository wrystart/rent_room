import { http } from '../utils/http';

import type { IBookRentRoomList } from '../models/BookRentRoomList';


// 获取预约租房列表
export const getBookRentRoomListApi = (): Promise<IBookRentRoomList> => {
  return http.get<IBookRentRoomList>('/auth/house/history')
}