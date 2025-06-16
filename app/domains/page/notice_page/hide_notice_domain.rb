module Page::NoticePage
  class HideNoticeDomain
    def execute(notice_id)
      notice = Notice.find_by(id: notice_id)
      return false unless notice

      notice.update(is_hide: true)
    end
  end
end
