import logging
import transaction
from zope.component.hooks import setSite
from plone import api


logger = logging.getLogger()
smtp_port = ${:mailhost-smtp-port}
setSite(app.Plone)
current_port = api.portal.get_registry_record('plone.smtp_port')

if current_port != smtp_port:
    logger.warn(
        'Changing SMTP port from "%s" to "%s"',
        current_port,
        smtp_port,
    )
    api.portal.set_registry_record('plone.smtp_port', smtp_port)
    transaction.commit()
