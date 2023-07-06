package com.beacon.business.bpm.framework.bpm.core.event;

import lombok.AllArgsConstructor;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.validation.annotation.Validated;

import javax.validation.Valid;

/**
 * {@link BpmProcessInstanceResultEvent} 的生产者
 *
 * @author Beacon
 */
@AllArgsConstructor
@Validated
public class BpmProcessInstanceResultEventPublisher {

    private final ApplicationEventPublisher publisher;

    public void sendProcessInstanceResultEvent(@Valid BpmProcessInstanceResultEvent event) {
        publisher.publishEvent(event);
    }

}
