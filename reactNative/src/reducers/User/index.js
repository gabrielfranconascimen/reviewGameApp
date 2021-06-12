const initialState = null

export default function user(state = initialState, action) {
  switch (action.type) {
    case 'SET_USER':
      return action.payload;
    case 'CLEAR_USER':
      return initialState;
    default:
      return state
  }
}